# Chocolatey Automatic Packages

This repository contains automated Chocolatey packages maintained by Menchen. 

These packages are kept up-to-date automatically using the [Chocolatey Automatic Package Updater Module (AU)](https://github.com/majkinetor/au).

## Packages included

| Package | Status | Description |
|---|---|---|
| [fzf](https://community.chocolatey.org/packages/fzf) | Automated | A command-line fuzzy finder. |
| [moolticute](https://community.chocolatey.org/packages/moolticute) | Manual | Moolticute is the companion app for the Mooltipass password manager. |

## Automation Details

Updates are checked and processed automatically via GitHub Actions. When a new version is detected upstream, the AU framework downloads the new binary, calculates the SHA256 hashes, updates the package scripts, and automatically pushes the compiled `.nupkg` to Chocolatey.org.
