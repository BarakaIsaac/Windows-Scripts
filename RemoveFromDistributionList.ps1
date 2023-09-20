# Define the email addresses to remove
$EmailAddressesToRemove = "Email Addresses"

# Define the name of the distribution group
$DistributionGroupName = "All Pollmans"

# Remove each email address from the distribution group
foreach ($EmailAddress in $EmailAddressesToRemove) {
    $result = Remove-DistributionGroupMember -Identity $DistributionGroupName -Member $EmailAddress -Confirm:$false
    if ($result -eq $true) {
        Write-Host "Removed $EmailAddress from $DistributionGroupName"
    } else {
        Write-Host "Failed to remove $EmailAddress from $DistributionGroupName"
    }
}
