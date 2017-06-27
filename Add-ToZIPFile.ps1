[CmdletBinding()]
Param(
    [string]$ZIPFileName,
    [string]$NewFileToAdd
)

try {
    [Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | Out-Null
    $zip = [System.IO.Compression.ZipFile]::Open($ZIPFileName,"Update")
    $FileName = [System.IO.Path]::GetFileName($NewFileToAdd)
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,$NewFileToAdd,$FileName,"Optimal") | Out-Null
    $Zip.Dispose()
    Write-Host "Successfully added $NewFileToAdd to $ZIPFileName "
} catch {
    Write-Warning "Failed to add $NewFileToAdd to $ZIPFileName . Details : $_"

}