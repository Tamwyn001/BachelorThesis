param (
    [String] $GnuScript,
    [String] $LatexPath,
    [String] $SimulationPath
)

function Remove-GhostCharacters {
    param (
        [string]$InputString
    )

    # Initialize an empty string to store the result
    $resultString = ""

    for ($i = 0; $i -lt $InputString.Length; $i++) {
        $char = $InputString[$i]
        $unicodeValue = [int][char]$char
        # Only append characters that are not ghosts
        if ($unicodeValue -ne 0) {
            $resultString += $char
        }
    }

    return $resultString
}
$gnuarg = '"'
$gnuarg = $gnuarg + 'targetSystem = '''+ "$SimulationPath" +''';'   #"'Correlation_cdagg_c_/meanline20x20/'"""
$gnuarg = $gnuarg + 'targetLatex = '''+ "$LatexPath" +''';' 
$gnuarg = $gnuarg + '"'
"Plotting and saving"
"gnuplot -e $gnuarg $GnuScript"
$tex_path = & gnuplot -e $gnuarg $GnuScript
#"$tex_path" is splited in [.,./../T] etx

$tex_path =  $tex_path


$target = $tex_path -replace '\.tex','' 
$replace = $target -replace '\.\./\.\./Thesis/', '' -replace '//', '/'

$content = Get-Content -Path "$tex_path" -Encoding UTF8 -RAW
$target = $target.Substring(0, $target.Length - 1)
$replace = $replace.Substring(0, $replace.Length - 1)
$content = $content -replace $target, $replace

$content = $content -replace '0\.00e\{\+00\}', '0'  -replace '0\.0e\{\+00\}', '0'  -replace '0e\{\+00\}', '0'
Set-Content -Path "$tex_path" -Value $content -Encoding UTF8

del "`$null" # delete the temp outputs file
"Task completed"
