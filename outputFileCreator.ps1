# Creates a sample output files with a random device type for each row

$outputFileCount = 5 # Number of output files to create
$rowCount = 100000 # Number of rows in each output file

$deviceTypes = @("Laptop", "Desktop", "Mobile")

for ($j = 1; $j -le $outputFileCount; $j++) # Loop to create multiple output files
{
    $outputData = @()
    $outputFile = "C:\Temp\example_output_file_$j.csv"
    write-host "Generating file: $outputFile"
    
    for ($i = 1; $i -le $rowCount; $i++) # Loop to create rows in each file
    {
        $deviceType = Get-Random $deviceTypes
        $row = "CUST-$i;$deviceType;$i;SERVICE-$i"
        $outputData += $row
    }
    # Write to file
    $outputData | Out-File -FilePath $outputFile -Encoding UTF8
}