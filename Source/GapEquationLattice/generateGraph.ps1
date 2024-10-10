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
$tex_path = & gnuplot -e $gnuarg $GnuScript
#"$tex_path" is splited in [.,./../T] etx

$tex_path = Remove-GhostCharacters -InputString $tex_path


$target = $tex_path -replace '.tex','' 
$replace = $target -replace '../../Thesis/', '' -replace '//', '/'

$content = Get-Content -Path "$tex_path"
$target = $target.Substring(0, $target.Length - 1)
$replace = $replace.Substring(0, $replace.Length - 1)
$content = $content -replace $target, $replace
Set-Content -Path "$tex_path" -Value $content -Encoding UTF8
del "`$null"
"Task completed"
