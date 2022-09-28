<powershell>
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CGI

choco install webpi -y
choco install webdeploy -y
choco install urlrewrite -y
choco install php -y

Disable-WindowsOptionalFeature -Online -FeatureName IIS-DirectoryBrowsing $url = "https://cdn.localwp.com/stable/latest/windows"

$iisWebDirectoryPath = "C:\Inetpub\wwwroot"
$websiteName = "demo"

Import-Module WebAdministration
Remove-Website -Name "Default Web Site"
Get-ChildItem $iisWebDirectoryPath -Recurse | Remove-Item -Recurse -Force 

$wordpressUrl = "https://wordpress.org/latest.zip"
$tempDirectoryPath = "C:\Windows\Temp"
$wordpressZipFilePath = "$tempDirectoryPath\wordpress.zip"
Invoke-WebRequest -Uri $wordpressUrl -OutFile $wordpressZipFilePath
Expand-Archive $wordpressZipFilePath -DestinationPath $iisWebDirectoryPath 
Rename-Item "$iisWebDirectoryPath\wordpress" "$iisWebDirectoryPath\$websiteName"

New-WebAppPool -Name $websiteName -Force 
New-Website -Name $websiteName -PhysicalPath "$iisWebDirectoryPath\$websiteName" -ApplicationPool $websiteName -Force

$acl = Get-Acl "$iisWebDirectoryPath\$websiteName"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS APPPOOL\demo","Modify, Synchronize", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl "$iisWebDirectoryPath\$websiteName"

Add-WebConfigurationProperty -Filter "//defaultDocument/files" -PSPath "IIS:\sites\$websiteName" -AtIndex 0 -Name "Collection" -Value "index.php"

#Rename-Item "$iisWebDirectoryPath\$websiteName\wp-config-sample.php" "$iisWebDirectoryPath\$websiteName\wp-config.php" -Force
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jbtyndall/aws-wordpress-iis/main/wp-config.php" -OutFile "$iisWebDirectoryPath\$websiteName\wp-config.php"

$phpDirectoryPath = "C:\tools\php81"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jbtyndall/aws-wordpress-iis/main/php.ini" -OutFile "$phpDirectoryPath\php.ini"
$acl = Get-Acl $phpDirectoryPath
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\IIS_IUSRS","Modify, Synchronize", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $phpDirectoryPath

New-WebHandler -Name "FastCGI" -Path "*.php" -Verb "*" -Modules "FastCgiModule" -ResourceType "File" -ScriptProcessor "$phpDirectoryPath\php-cgi.exe"
Add-WebConfiguration "system.webServer/fastCGI" -Value @{"fullPath" = "$phpDirectoryPath\php-cgi.exe"}

</powershell> 
