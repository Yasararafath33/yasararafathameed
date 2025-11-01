# PowerShell Script for Bulk User Creation in Active Directory
# Automated user onboarding process for HR department

Import-Module ActiveDirectory

$Users = Import-Csv "C:\Scripts\NewUsers.csv"

foreach ($User in $Users) {
    $Username = $User.FirstName.Substring(0,1) + $User.LastName
    New-ADUser -Name "$($User.FirstName) $($User.LastName)" `
               -GivenName $User.FirstName `
               -Surname $User.LastName `
               -SamAccountName $Username `
               -UserPrincipalName "$Username@company.com" `
               -Path "OU=Users,DC=company,DC=com" `
               -AccountPassword (ConvertTo-SecureString "TempPassword123" -AsPlainText -Force) `
               -Enabled $true
    Write-Output "Created user: $Username"
}