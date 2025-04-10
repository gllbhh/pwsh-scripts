$xmen = @('Wolverine', 'Cyclops', 'Storm', 'Professor X', 'Gambit', 'Dr. Jean Grey')
$counter = 0

# while loop
while($counter -ne $xmen.Length) {
    Write-Host $xmen[$counter] "is a mutatnt! His name length is" $xmen[$counter].Length "symbols"
    $counter++
}
Write-Host
# Do while loop
$counter = 0
Do {
    Write-Host $xmen[$counter] "has joined the team"
    $counter++
    }while($counter -ne $xmen.Length)