# Prompt the user for the target user's email address
$targetUser = Read-Host "Enter the target user's email address"

# Prompt the user for the domain
$domain = Read-Host "Enter the domain (e.g., example.com) to assign permissions to"

# Connect to Exchange Online PowerShell
$UserCredential = Get-Credential
Connect-ExchangeOnline -UserPrincipalName $UserCredential.UserName -ShowProgress $true

# Get all mailbox users under the specified domain
$mailboxUsers = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Where-Object { $_.PrimarySmtpAddress -like "*@$domain" }

# Loop through each mailbox user and assign permissions to the target user
foreach ($user in $mailboxUsers) {
    # Skip the target user
    if ($user.PrimarySmtpAddress -eq $targetUser) {
        continue
    }
    
    # Assign read and manage permissions to the target user
    Add-MailboxPermission -Identity $user.PrimarySmtpAddress -User $targetUser -AccessRights ReadPermission, FullAccess -InheritanceType All -Confirm:$false

    # Assign "Send As" permission to the target user
    Add-RecipientPermission -Identity $user.PrimarySmtpAddress -Trustee $targetUser -AccessRights SendAs -Confirm:$false
    
    # Assign "Send on Behalf Of" permission to the target user
    Set-Mailbox -Identity $user.PrimarySmtpAddress -GrantSendOnBehalfTo @{Add=$targetUser} -Confirm:$false
    
}

# Disconnect from Exchange Online PowerShell session
Disconnect-ExchangeOnline -Confirm:$false