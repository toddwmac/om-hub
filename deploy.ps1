#Requires -Version 5.0
<#
  .SYNOPSIS
    One-command deploy for the om-xample GitHub Pages site.

  .DESCRIPTION
    Stages all changes, commits them, and pushes to GitHub.
    GitHub Pages then rebuilds and publishes automatically (usually within ~1 minute).

  .EXAMPLE
    .\deploy.ps1                  # auto commit message (timestamp)
    .\deploy.ps1 -m "Add Q3 chart"
#>
param(
    [Parameter()][string]$m = ""
)

$ErrorActionPreference = "Stop"

# Ensure we are in the repo root (same folder as this script).
Set-Location -Path $PSScriptRoot

git add -A
$status = git status --porcelain
if (-not $status) {
    Write-Host "Nothing to commit - working tree is clean." -ForegroundColor Yellow
    exit 0
}

if ([string]::IsNullOrWhiteSpace($m)) {
    $m = "Update site $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
}

git commit -m $m
git push origin HEAD

Write-Host ""
Write-Host ("Pushed. GitHub Pages will rebuild in about a minute: " `
        + "https://toddwmac.github.io/om-xample/") -ForegroundColor Green
