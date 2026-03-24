Import-Module au

$releases = 'https://developers.yubico.com/yubikey-manager/Releases/'

function global:au_GetLatest {
    $req = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = 'yubikey-manager-(?<version>[\d\.]+)-win64\.msi'
    $matches = [regex]::Matches($req.Content, $regex)
    
    if ($matches.Count -eq 0) { throw "Could not find any MSI versions on the releases page!" }

    # Extract all versions found, sort them descending, and pick the absolute highest
    $latestVersion = $matches | ForEach-Object { [version]$_.Groups['version'].Value } | Sort-Object -Descending | Select-Object -First 1
    $versionString = $latestVersion.ToString()
    
    # Reconstruct the exact URL based on the version we found
    $url64 = "https://developers.yubico.com/yubikey-manager/Releases/yubikey-manager-$versionString-win64.msi"

    # Pass the data back to AU
    return @{
        Version = $versionString
        URL64   = $url64
    }
}

# Certificate Pinning
function global:au_BeforeUpdate {
    $tempFile = Join-Path $env:TEMP "yubikey-manager-$($Latest.Version).msi"
    Write-Host "Downloading $($Latest.URL64) to calculate checksum and verify signature..."
    Invoke-WebRequest -Uri $Latest.URL64 -OutFile $tempFile

    $sig = Get-AuthenticodeSignature -FilePath $tempFile
    
    # Check 1: Is the signature intact and mathematically valid?
    if ($sig.Status -ne 'Valid') {
        Remove-Item $tempFile
        throw "FATAL: Signature verification failed! Status: $($sig.Status). The file might be corrupted."
    }

    # These are the 3 "current" SHA256 fingerprints from Yubico's site 
    $validFingerprints = @(
        "33:25:6D:85:EE:41:F6:DF:D7:92:3B:AC:16:EC:E9:9F:98:CB:D6:A8:9D:71:90:CE:06:31:1A:68:55:A4:DA:67", # EV Current
        "EC:BF:1B:DA:58:17:48:1C:51:FA:E7:B8:BD:FA:4C:09:A8:26:BB:05:05:8D:13:0D:34:32:2E:A1:94:C7:73:07", # EC Current
        "A0:1E:11:73:E5:15:18:09:53:8D:FD:24:92:D5:C2:91:DB:F4:EC:67:B5:A5:CF:06:13:71:98:5E:34:36:5D:E6"  # RSA Current
    ) -replace ':' # This magically removes the colons from all items in the array at once
    
    # Calculate the SHA256 fingerprint of the embedded certificate
    $certStream = [System.IO.MemoryStream]::new($sig.SignerCertificate.RawData)
    $actualFingerprint = (Get-FileHash -InputStream $certStream -Algorithm SHA256).Hash
    
    # Check 2: Does the certificate match Yubico's published pins?
    if ($actualFingerprint -notin $validFingerprints) {
        Remove-Item $tempFile
        throw "FATAL: Certificate Pinning failed! Unknown fingerprint found: $actualFingerprint"
    }
    
    Write-Host "Success: Binary is valid and matches Yubico's pinned certificate fingerprints!"
    # ==========================================================

    # Calculate the SHA256 Checksum for the Chocolatey package
    $Latest.Checksum64 = (Get-FileHash -Path $tempFile -Algorithm SHA256).Hash
    $Latest.ChecksumType64 = 'sha256'
    
    # Cleanup the temp file
    Remove-Item $tempFile
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

Update-Package -ChecksumFor None
