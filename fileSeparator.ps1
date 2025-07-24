$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

$folder = "C:\Temp"
$outputFolder = "C:\Temp"
$encoding = [System.Text.Encoding]::Default

$uudetRivit = @()
$vanhatRivit = @()

$items = Get-ChildItem -Path $folder -Filter "example_output_file_*.csv"

$i = 1
Write-Host "----"

foreach ($file in $items) {
    $content = Get-Content -Path $file.FullName -Encoding Default
    $intRivitTiedostossa = $content.Count
    $intRivitUudet = 0
    $intRivitVanhat = 0

    Write-Host ("[{0} / {1}] [{2}]" -f $i, $items.Count, $file.Name)

    foreach ($row in $content) {
        $columns = $row -split ';'
        $rivi = [PSCustomObject]@{
            CUSTOMER    = $columns[0]
            DEVICE_TYPE = $columns[1]
            NUMBER      = $columns[2]
            SERVICE     = $columns[3]
        }

        if ($row -like "*Laptop*") {
            $uudetRivit += $rivi
            $intRivitUudet++
        } else {
            $vanhatRivit += $rivi
            $intRivitVanhat++
        }
    }

    Write-Host ("Rivejä yht: {0}" -f $intRivitTiedostossa)
    Write-Host ("Laptop: {0}" -f $intRivitUudet)
    Write-Host ("Muita: {0}" -f $intRivitVanhat)
    Write-Host "----"

    $i++
}

$uudetRivit | ForEach-Object {
    "$($_.CUSTOMER);$($_.DEVICE_TYPE);$($_.NUMBER);$($_.SERVICE)"
} | Set-Content -Path (Join-Path $outputFolder "laptops_ps.csv") -Encoding Default

$vanhatRivit | ForEach-Object {
    "$($_.CUSTOMER);$($_.DEVICE_TYPE);$($_.NUMBER);$($_.SERVICE)"
} | Set-Content -Path (Join-Path $outputFolder "others_ps.csv") -Encoding Default

$stopwatch.Stop()
Write-Host ("Aikaa kului: {0} sekuntia" -f $stopwatch.Elapsed.TotalSeconds)
