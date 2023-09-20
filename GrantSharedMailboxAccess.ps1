# Define the user's email address and an array of shared mailbox names
$UserEmailAddress = "Email addresses"
$SharedMailboxes =  "Shared Mailboxes"

# Grant the user access to each shared mailbox
$SharedMailboxes | ForEach-Object {
   $MailboxName = $_
   Add-MailboxPermission -Identity $MailboxName -User $UserEmailAddress -AccessRights FullAccess
}
