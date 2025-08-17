
$folder = "C:\Users\user\Downloads\svg\"

Get-ChildItem -Path $folder -Filter *.svg | ForEach-Object {
    $input = $_.FullName
    $output = [System.IO.Path]::ChangeExtension($input, ".pdf")
    inkscape $input --export-type=pdf --export-filename=$output
}
