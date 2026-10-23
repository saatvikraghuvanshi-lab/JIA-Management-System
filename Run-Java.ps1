param(
    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

$ErrorActionPreference = "Stop"

# Project layout:
#   <repo>/AirportManagementSystem/src     -> package root (package util; lives here)
#   <repo>/AirportManagementSystem/lib     -> driver jars
$srcDir = Join-Path $PSScriptRoot "AirportManagementSystem\src"
$libDir = Join-Path $PSScriptRoot "AirportManagementSystem\lib"

$resolved = (Resolve-Path -LiteralPath $FilePath).Path
$srcFull = (Resolve-Path -LiteralPath $srcDir).Path

if (-not $resolved.StartsWith($srcFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    Write-Error "File is not under the source root '$srcFull': $resolved"
    exit 1
}

# Derive package name from the path relative to the source root
$rel = $resolved.Substring($srcFull.Length).TrimStart('\', '/')
$relDir = Split-Path -Parent $rel
$packageName = ($relDir -replace '[\\/]', '.')
$className = [System.IO.Path]::GetFileNameWithoutExtension($resolved)

$sep = [System.IO.Path]::PathSeparator
$libJars = ""
if (Test-Path $libDir) {
    $libJars = ((Get-ChildItem -Path $libDir -Filter *.jar -ErrorAction SilentlyContinue |
            ForEach-Object { $_.FullName }) -join $sep)
}

# Compile from the package root so javac resolves other classes in this package
$classpath = $srcFull
if ($libJars) { $classpath = "$srcFull$sep$libJars" }

Push-Location $srcFull
try {
    $javacArgs = @('-cp', $classpath, $rel)
    & javac @javacArgs
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    # Files directly under src have no package: use the bare class
    # name (a leading dot would make java fail to find the class).
    $mainClass = $className
    if ($packageName) { $mainClass = "$packageName.$className" }

    # UTF-8 stdout so the ticket's arrow character renders correctly.
    # (Args must be splatted: Windows PowerShell splits unquoted
    #  -Dfile.encoding=UTF-8 at the dot and java fails to start.)
    $javaArgs = @('-Dfile.encoding=UTF-8', '-Dsun.stdout.encoding=UTF-8',
                  '-cp', $classpath, $mainClass)
    & java @javaArgs
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
