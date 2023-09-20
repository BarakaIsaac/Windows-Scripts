# Define the user's email address and display name
$UserEmailAddress = "UserEmailAddress"
$UserDisplayName = "UserDisplayName"

# Define an array of shared mailbox email addresses
$SharedMailboxes = "SharedMailboxes"

# Grant "Send As" permission for each shared mailbox
foreach ($SharedMailbox in $SharedMailboxes) {
    Add-RecipientPermission -Identity $SharedMailbox -Trustee $UserEmailAddress -AccessRights SendAs -Confirm:$false
    Write-Host "Granted 'Send As' permission for $UserEmailAddress on $SharedMailbox"
}
