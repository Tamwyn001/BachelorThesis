# Removes old auto-generated PDF graphs
param (
    [String] $path
)

# Replace forward slashes with backslashes for consistency
$normalizedPath = $path -replace '/', '\'

# Check if the path exists before attempting to delete
if (Test-Path -Path $normalizedPath) {
    del $normalizedPath
} else {
    Write-Host "Path does not exist: $normalizedPath"
}

# Construct the path to delete PDF files
$to_del = $normalizedPath -replace '\\\\', '\\'  # Replace double backslashes with single


# Check if the wildcard path exists before attempting to delete files
if (Test-Path -Path $to_del) {
    del $to_del
} else {
    Write-Host "No PDF files found to delete in: $to_del"
}
