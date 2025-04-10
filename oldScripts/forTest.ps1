# for loop with a counter
$holoPeeps = @('Master Chief', 'Cortana', 'Captain keys', 'Flood')
For ($counter = 0; $counter -le $holoPeeps.Length - 1; $counter++){
 Write-Host "Holly smokes, it's" $holoPeeps[$counter]   
}

# foreach loop
Foreach ($peep in $holoPeeps) {
     Write-Host $peep "has arrived!"
}