﻿function Delete-LocalAccount{
[Cmdletbinding()]
param(
[Parameter(Mandatory=$False,
           Position = 0,
      ValueFromPipelineByPropertyName=$True,
      HelpMessage = "Enter the target computer name to be targeted. Can be multiple names.")]
      [Alias('Hostname','CN', 'ComputerName')]
    [String[]]$CName,

    [Parameter(Mandatory=$False,
           Position = 1,
      ValueFromPipelineByPropertyName=$True,
      HelpMessage = "Enter the target accounts to disable. Can be multiple accounts.")]
      [Alias('AccountName')]
    [String[]]$Usernames
    )

    BEGIN{
        $Computer = @()

        $OutPath = "C:\DeletedLocalAccounts.CSV"
        Remove-Item -Path $OutPath -Force -EA SilentlyContinue

        $FileHandle = New-Object System.IO.StreamWriter -Arg $OutPath
        $FileHandle.AutoFlush = $True

    }

    PROCESS{
        foreach($CN in $CName){
              $Computer = [ADSI]"WinNT://$CN"
              foreach($User in $Usernames){
                $Computer.Delete("User", $User)

                $Line = "$CN, " + $User
                $FileHandle.WriteLine($Line)
            }
        }
    }

    END{
        return $Account
    }
}
