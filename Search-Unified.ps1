$StartDate = Get-Date "2023-06-06"
$EndDate = Get-Date "2023-07-01"

$GroupCreationEvents = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType "AzureActiveDirectoryGroupSettings" -Operations "Add group"
foreach ($Event in $GroupCreationEvents) {
    $CreationTime = $Event.CreationDate
    $UserWhoCreatedGroup = $Event.UserId
    Write-Host "Group created by $UserWhoCreatedGroup on $CreationTime"
}
