Install-Module SentinelARConverter -Force
$folderPath = ".\"
$yamlFileNames = Get-ChildItem -Path $folderPath -Filter "*.yaml" -recurse | % { $_.FullName }
$yamlFileNames
foreach ($item in $yamlFileNames) {
          Convert-SentinelARYamlToArm -Filename "$item" -UseOriginalFilename }

$repositoryPath = ".\"
Write-Host "Repository Path: $repositoryPath"
Move-Item -Path .\*.json -Destination $repositoryPath
Get-ChildItem -Path $repositoryPath
cd "$repositoryPath\"
git checkout -b main
git config --global user.email "samik.n.roy@gmail.com"
git config --global user.name "Samik Roy"
git add .
git commit -m "Add converted JSON files"
git push origin main
git fetch origin main:tmp
git rebase tmp
git push origin HEAD:main
git branch -D tmp
