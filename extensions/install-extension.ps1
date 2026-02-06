$ExtensionName = "atomic-agents"
$SourcePath = $PSScriptRoot
$GlobalExtensionsDir = "$HOME\.gemini\extensions"
$TargetDir = "$GlobalExtensionsDir\$ExtensionName"

Write-Host "Installing '$ExtensionName' extension..." -ForegroundColor Cyan

# 1. Create Global Extensions Directory if not exists
if (-not (Test-Path -Path $GlobalExtensionsDir)) {
    New-Item -ItemType Directory -Force -Path $GlobalExtensionsDir | Out-Null
    Write-Host "Created global extensions directory: $GlobalExtensionsDir"
}

# 2. Remove existing installation if present
if (Test-Path -Path $TargetDir) {
    Write-Warning "Extension '$ExtensionName' already exists at $TargetDir."
    $confirm = Read-Host "Overwrite? (y/n)"
    if ($confirm -ne 'y') {
        Write-Host "Installation cancelled."
        exit
    }
    Remove-Item -Path $TargetDir -Recurse -Force
}

# 3. Copy Extension Files
# We copy the contents of the current folder to the target, excluding the install script itself and git artifacts
New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
Write-Host "Copying files to $TargetDir..."

Get-ChildItem -Path $SourcePath -Exclude ".git", "install-extension.ps1" | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $TargetDir -Recurse -Force
}

Write-Host "Success! Extension installed." -ForegroundColor Green
Write-Host "You can now verify it by running 'gemini extensions list' (if available) or checking the directory."
