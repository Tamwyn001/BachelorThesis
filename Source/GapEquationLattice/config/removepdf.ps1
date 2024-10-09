# Used to remove the old auto generated 
#  pdf graph, otherwise wont be modified

$path = $args[0]
$path -replace '/', '\'
del $path
