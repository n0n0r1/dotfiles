# envs
[System.Environment]::SetEnvironmentVariable("GOPATH", $env:USERPROFILE, "User")
[System.Environment]::SetEnvironmentVariable("PYTHONUSERBASE", "$env:USERPROFILE", "User")

$newPath = @(
  "$env:USERPROFILE\bin"
  "$env:USERPROFILE\.dotfiles\bin"
  "$env:USERPROFILE\scoop\shims"
  "$env:USERPROFILE\scoop\apps\python\current"
  "$env:USERPROFILE\scoop\apps\python\current\Scripts"
  "$env:USERPROFILE\scoop\apps\python27\current\scripts"
  "$env:USERPROFILE\scoop\apps\nodejs-lts\current\bin"
  "$env:USERPROFILE\scoop\apps\nodejs-lts\current"
  "$env:USERPROFILE\scoop\apps\ruby\current\gems\bin"
  "$env:USERPROFILE\scoop\apps\ruby\current\bin"
  "$env:USERPROFILE\scoop\apps\git\current\usr\bin"
  "$env:USERPROFILE\scoop\apps\git\current\mingw64\bin"
  "$env:USERPROFILE\scoop\apps\git\current\mingw64\libexec\git-core"
  "$env:USERPROFILE\AppData\Local\Programs\Python\Launcher"
  "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"
) -join ";"

$oldPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($oldPath -ne $newPath) {
  [System.Environment]::SetEnvironmentVariable("_PATH_" + (Get-Date -UFormat "%Y%m%d"), $oldPath, "User")
}
[System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
$env:PATH = $newPath + ";" + $env:PATH

$DOTFILES = "$env:USERPROFILE\.dotfiles"

$ErrorActionPreference = "Stop"

try {
  Get-Command -Name scoop -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Invoke-Expression (new-object net.webclient).downloadstring("https://get.scoop.sh")
}

$UTILS = @(
  "aria2"
  "lessmsi"
  "dark"
  "7zip"
  "git"
)

$PACKAGES = @(
  "bat"
  "fzf"
  "go"
  "googlechrome"
  "msys2"
  "neovim"
  "nodejs-lts"
  "pwsh"
  "python"
  "ripgrep"
  "vscode"
  "powertoys"
  "android-studio"
  "jq"
)

scoop install $UTILS
scoop bucket add versions
scoop bucket add extras
scoop bucket add java
scoop update *
scoop install $PACKAGES
scoop install "python27"
scoop reset "python"

# python2
$PIP2PACKAGES = @(
  "pip"
  "pynvim"
)
python2 -m pip install --upgrade $PIP2PACKAGES

# python3
$PIP3PACKAGES = @(
  "pip"
  "pynvim"
)
python -m pip install --upgrade $PIP3PACKAGES

if (Test-Path ("$DOTFILES")) {
  Set-Location $DOTFILES
  git pull
}
else {
  git config --global core.autoCRLF false
  git clone https://github.com/n0n0r1/dotfiles.git $env:USERPROFILE\.dotfiles
}

Start-Process -FilePath "$DOTFILES\bin\deploy.bat"
