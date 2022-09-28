<script>
mkdir "C:\Inetpub\wwwroot\demo"
icacls "C:\Inetpub\wwwroot\demo" /grant "IIS AppPool\demo":(OI)(CI)M /T
mkdir "C:\tools\php81"
icacls "C:\tools\php81" /grant "IIS_IUSRS":(OI)(CI)M /T
</script>

<powershell>
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CGI

choco install webpi -y
choco install webdeploy -y
choco install urlrewrite -y
choco install php -y

$websiteName = "demo"

$wordpressUrl = "https://wordpress.org/latest.zip"
$tempDirectoryPath = "C:\Windows\Temp"
$wordpressZipFilePath = "$tempDirectoryPath\wordpress.zip"
Invoke-WebRequest -Uri $wordpressUrl -OutFile $wordpressZipFilePath
$iisWebDirectoryPath = "C:\Inetpub\wwwroot"
Expand-Archive $wordpressZipFilePath -DestinationPath $iisWebDirectoryPath 
Rename-Item "$iisWebDirectoryPath\wordpress" "$iisWebDirectoryPath\$websiteName"

Disable-WindowsOptionalFeature -Online -FeatureName IIS-DirectoryBrowsing $url = "https://cdn.localwp.com/stable/latest/windows"

Import-Module WebAdministration
Remove-Website -Name "Default Website"

New-WebAppPool -Name $websiteName -Force 
New-Website -Name $websiteName -PhysicalPath "$iisWebDirectoryPath\$websiteName" -ApplicationPool $websiteName -Force
Add-WebConfigurationProperty -Filter "//defaultDocument/files" -PSPath "IIS:\sites\$websiteName" -AtIndex 0 -Name "Collection" -Value "index.php"

Rename-Item "$iisWebDirectoryPath\$websiteName\wp-config-sample.php" "$iisWebDirectoryPath\$websiteName\wp-config.php" -Force
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jbtyndall/aws-wordpress-iis/main/php.ini" -OutFile "C:\tools\php81\php.ini" -Force

New-WebHandler -Name "FastCGI" -Path "*.php" -Verb "*" -Modules "FastCgiModule" -ResourceType "File" -ScriptProcessor "C:\tools\php81\php-cgi.exe"
</powershell>
