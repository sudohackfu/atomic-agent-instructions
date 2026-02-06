param(
    [switch]$Debug
)

$ErrorActionPreference = "Stop"

function Update-JsonFile {
    param(
        [string]$SourceFile,
        [string]$TargetFile,
        [string]$Description
    )

    Write-Host "Updating $Description..." -ForegroundColor Blue

    # Read source updates
    if (-not (Test-Path $SourceFile)) {
        Write-Warning "Source file $SourceFile not found. Skipping $Description update."
        return
    }

    $jsonupdate = @(Get-Content $SourceFile -Raw -Encoding UTF8)
    if ($Debug) {
        Write-Host "DEBUG: Raw $Description source content:" -ForegroundColor Cyan
        Write-Host $jsonupdate -ForegroundColor Yellow
    }

    $jsonupdate_obj = $jsonupdate | ConvertFrom-Json
    if ($Debug) {
        Write-Host "DEBUG: Parsed $Description source object:" -ForegroundColor Cyan
        Write-Host ($jsonupdate_obj | ConvertTo-Json -Depth 10) -ForegroundColor Yellow
    }

    # Read existing target or create empty
    if (Test-Path $TargetFile) {
        $JsonContent = @(Get-Content $TargetFile -Raw -Encoding UTF8)
        $Settings = $JsonContent | ConvertFrom-Json
        Write-Host "Found existing $Description" -ForegroundColor Yellow
    } else {
        $Settings = [PSCustomObject]@{}
        Write-Host "Creating new $Description..." -ForegroundColor Green
    }

    # Merge updates
    foreach ($prop in $jsonupdate_obj.PSObject.Properties) {
        $existingValue = $Settings.$($prop.Name)
        $newValue = $prop.Value
        $existingJson = if ($null -ne $existingValue) { $existingValue | ConvertTo-Json -Depth 10 -Compress } else { $null }
        $newJson = $newValue | ConvertTo-Json -Depth 10 -Compress

        if ($Debug) {
            Write-Host "DEBUG: Processing property '$($prop.Name)':" -ForegroundColor Cyan
            Write-Host "  Existing value: $existingValue" -ForegroundColor Yellow
            Write-Host "  New value: $newValue" -ForegroundColor Yellow
            Write-Host "  Existing JSON: $existingJson" -ForegroundColor Yellow
            Write-Host "  New JSON: $newJson" -ForegroundColor Yellow
            Write-Host "  JSONs equal: $($existingJson -eq $newJson)" -ForegroundColor Yellow
        }

        if ($existingJson -ne $newJson) {
            Add-Member -InputObject $Settings -MemberType NoteProperty -Name $prop.Name -Value $newValue -Force
            Write-Host "Updated $($prop.Name)" -ForegroundColor Gray
        } else {
            Write-Host "$($prop.Name) already up to date" -ForegroundColor Gray
        }
    }

    # Format and save
    $finalJson = $Settings | ConvertTo-Json -Depth 10 -Compress
    if ($Debug) {
        Write-Host "DEBUG: Compact JSON:" -ForegroundColor Cyan
        Write-Host $finalJson -ForegroundColor Yellow
    }

    $indentedJson = ($finalJson | ConvertFrom-Json) | ConvertTo-Json -Depth 100
    $indentation = 2
    $indent = 0
    $regexUnlessQuoted = '(?=([^"]*"[^"]*")*[^"]*$)'
    $result = $indentedJson -split '\r?\n' |
        ForEach-Object {
            if ($_ -match "[}\]]$regexUnlessQuoted") {
                $indent = [Math]::Max($indent - $indentation, 0)
            }
            $line = (' ' * $indent) + ($_.TrimStart() -replace ":\s+$regexUnlessQuoted", ': ')
            if ($_ -match "[\{\[]$regexUnlessQuoted") {
                $indent += $indentation
            }
            $line
        }
    $completeResult = $result -Join [Environment]::NewLine
    $completeResult = $completeResult -replace "\[\s*\]$regexUnlessQuoted", '[]'
    $completeResult = $completeResult -replace "\{\s*\}$regexUnlessQuoted", '{}'
    $finalJson = $completeResult

    if ($Debug) {
        Write-Host "DEBUG: Final formatted JSON to be saved:" -ForegroundColor Green
        Write-Host $finalJson -ForegroundColor Yellow
        Write-Host "DEBUG: Settings object type: $($Settings.GetType())" -ForegroundColor Cyan
        Write-Host "DEBUG: Final JSON type: $($finalJson.GetType())" -ForegroundColor Cyan
    }

    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    
    # Ensure directory exists
    $parentDir = Split-Path $TargetFile -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    [System.IO.File]::WriteAllText($TargetFile, $finalJson, $utf8NoBom)
    Write-Host "$Description updated successfully." -ForegroundColor Green
}

$GeminiRoot = "$HOME\.gemini"
$ExtensionsRoot = Join-Path $GeminiRoot "extensions"
$SourceExtensions = Join-Path $PSScriptRoot "extensions"

Write-Host "Installing Atomic Agents Scaffolder Extension..." -ForegroundColor Blue

if (-not (Test-Path $SourceExtensions)) {
    Write-Error "Source extensions directory '$SourceExtensions' not found."
    exit 1
}

if (-not (Test-Path $ExtensionsRoot)) {
    New-Item -ItemType Directory -Path $ExtensionsRoot -Force | Out-Null
}

Get-ChildItem $SourceExtensions -Directory | ForEach-Object {
    Write-Host "Installing extension: $($_.Name)" -ForegroundColor Cyan
    Copy-Item -Path $_.FullName -Destination $ExtensionsRoot -Recurse -Force
}

$EnablementFile = Join-Path $ExtensionsRoot "extension-enablement.json"
$EnablementSource = Join-Path $PSScriptRoot "extension-enablement.json"
Update-JsonFile -SourceFile $EnablementSource -TargetFile $EnablementFile -Description "extension-enablement.json"

Write-Host "`nInstallation Complete!" -ForegroundColor Green
Write-Host "Run /refresh in Gemini to activate the extension." -ForegroundColor Yellow
