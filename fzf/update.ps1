Import-Module au

$releases = 'https://api.github.com/repos/junegunn/fzf/releases/latest'

function global:au_GetLatest {
    $release = Invoke-RestMethod -Uri $releases
    
    # 1. Extract version
    $version = $release.tag_name -replace '^v',''
    
    # 2. Find the exact URLs for both architectures
    $url64 = $release.assets | Where-Object { $_.name -match 'windows_amd64\.zip$' } | Select-Object -ExpandProperty browser_download_url
    $urlArm64 = $release.assets | Where-Object { $_.name -match 'windows_arm64\.zip$' } | Select-Object -ExpandProperty browser_download_url

    # 3. Calculate the ARM64 checksum manually (AU framework only auto-calculates x86/x64)
    $tempFile = Join-Path $env:TEMP "fzf_arm64_$version.zip"
    Invoke-WebRequest -Uri $urlArm64 -OutFile $tempFile -UseBasicParsing
    $checksumArm64 = (Get-FileHash -Path $tempFile -Algorithm SHA256).Hash
    Remove-Item $tempFile -Force

    # 4. Return the gathered data back to the AU framework
    @{
        Version       = $version
        URL64         = $url64
        URLArm64      = $urlArm64
        ChecksumArm64 = $checksumArm64
        ReleaseNotes  = $release.html_url
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*\`$url64\s*=\s*)('.*')"           = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*\`$checksum64\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*\`$urlArm64\s*=\s*)('.*')"        = "`$1'$($Latest.URLArm64)'"
            "(?i)(^\s*\`$checksumArm64\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumArm64)'"
        }
    }
}

Update-Package -ChecksumFor 64
