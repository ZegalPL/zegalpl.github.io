param(
    [string]$InkscapePath = "inkscape"
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$imgDir = Join-Path $root "img"

$assets = @(
    @{ In = "linkedin-background.svg"; Out = "linkedin-background.png"; Width = 1128; Height = 191 },
    @{ In = "facebook-background.svg"; Out = "facebook-background.png"; Width = 851; Height = 315; MaxKB = 100 },
    @{ In = "twitter-background.svg"; Out = "twitter-background.png" }
)

if (-not (Get-Command $InkscapePath -ErrorAction SilentlyContinue)) {
    $candidates = @(
        "C:\Program Files\Inkscape\bin\inkscape.exe",
        "C:\Program Files\Inkscape\inkscape.exe",
        "C:\Program Files (x86)\Inkscape\bin\inkscape.exe",
        "C:\Program Files (x86)\Inkscape\inkscape.exe"
    )

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            $InkscapePath = $candidate
            break
        }
    }
}

if (-not (Get-Command $InkscapePath -ErrorAction SilentlyContinue)) {
    Write-Error "Inkscape not found. Install Inkscape, add it to PATH, or pass -InkscapePath with a valid executable path."
}

foreach ($asset in $assets) {
    $inFile = Join-Path $imgDir $asset.In
    $outFile = Join-Path $imgDir $asset.Out

    if (-not (Test-Path $inFile)) {
        Write-Warning "Skipping missing file: $inFile"
        continue
    }

    $args = @(
        $inFile,
        "--export-type=png",
        "--export-filename=$outFile"
    )

    if ($asset.ContainsKey("Width") -and $asset.ContainsKey("Height")) {
        $args += "--export-width=$($asset.Width)"
        $args += "--export-height=$($asset.Height)"
    }

    & $InkscapePath @args | Out-Null

    if ($asset.ContainsKey("MaxKB")) {
        $sizeKB = [math]::Round((Get-Item $outFile).Length / 1KB, 1)
        if ($sizeKB -gt [double]$asset.MaxKB) {
            Write-Warning "$($asset.Out) is $sizeKB KB (target <= $($asset.MaxKB) KB)."
        }
    }

    Write-Host "Exported $($asset.In) -> $($asset.Out)"
}

Write-Host "Done."
