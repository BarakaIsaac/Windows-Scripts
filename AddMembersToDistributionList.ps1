# Define the distribution group and domain
$DistributionGroupName = "DistributionGroupName"
$DomainToInclude = "company domain"

# Debugging output
Write-Host "Fetching users from the domain..."
$UsersToAdd = Get-Recipient | Where-Object { $_.PrimarySmtpAddress -like "*@*$DomainToInclude*" }
Write-Host "Found $($UsersToAdd.Count) users from the domain."

# Add users to the distribution group
$UsersToAdd | ForEach-Object {
    Write-Host "Adding $($_.PrimarySmtpAddress) to $DistributionGroupName..."
    Add-DistributionGroupMember -Identity $DistributionGroupName -Member $_.PrimarySmtpAddress
    Write-Host "Added $($_.PrimarySmtpAddress) to $DistributionGroupName."
}

