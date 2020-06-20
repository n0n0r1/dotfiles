Param([String]$mode)

if ($mode -eq "i") {
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

    # WSL用環境変数の設定
    [System.Environment]::SetEnvironmentVariable("WSLENV", "USERPROFILE:USERNAME", "User")

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
    "ghq"
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

    # dotfiles をダウンロード
    if (-Not (Test-Path ("$DOTFILES"))) {
    git config --global core.autoCRLF false
    git clone https://github.com/n0n0r1/dotfiles.git $env:USERPROFILE\.dotfiles
    }

    # keyhacのインストール
    if (-Not (Test-Path ("$env:USERPROFILE\bin\keyhac"))) {
        (New-Object Net.WebClient).DownloadFile("http://crftwr.github.io/keyhac/download/keyhac_182.zip", ".\keyhac.zip")
        unzip .\keyhac.zip -d $env:USERPROFILE\bin
    }

    # keyhacをOS起動時に起動する
    if (-Not (Test-Path ("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\keyhac.lnk"))) {
        $Shortcut = (New-Object -ComObject WScript.Shell).createshortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\keyhac.lnk")
        $Shortcut.TargetPath = "$env:USERPROFILE\bin\keyhac\keyhac.exe"
        $Shortcut.IconLocation = "$env:USERPROFILE\bin\keyhac\keyhac.exe"
        $Shortcut.Save()
    }
} elseif ($mode -eq "d") {

    # keyhac
    if (-Not (Test-Path ("$env:USERPROFILE\bin\keyhac\config.py"))) {
        New-Item -Type SymbolicLink $env:USERPROFILE\bin\keyhac\config.py -Value $env:USERPROFILE\.dotfiles\keyhac\config.py
    } elseif (-Not ((Get-Item ("$env:USERPROFILE\bin\keyhac\config.py")).Attributes.ToString() -match "ReparsePoint")) {
        copy $env:USERPROFILE\bin\keyhac\config.py $env:USERPROFILE\bin\keyhac\config.py.bak
        rm $env:USERPROFILE\bin\keyhac\config.py
        New-Item -Type SymbolicLink $env:USERPROFILE\bin\keyhac\config.py -Value $env:USERPROFILE\.dotfiles\keyhac\config.py
    }

    # Windows Terminal
    $WindowsTerminalPath = Get-ChildItem $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_*\LocalState\
    if (-Not (Test-Path ("$WindowsTerminalPath\settings.json"))) {
        New-Item -Type SymbolicLink $WindowsTerminalPath\settings.json -Value $env:USERPROFILE\.dotfiles\WindowsTerminal\settings.$env:COMPUTERNAME.json
    } elseif (-Not ((Get-Item ("$WindowsTerminalPath\settings.json")).Attributes.ToString() -match "ReparsePoint")) {
        copy $WindowsTerminalPath\settings.json $env:USERPROFILE\.dotfiles\WindowsTerminal\settings.$env:COMPUTERNAME.json
        rm $WindowsTerminalPath\settings.json
        New-Item -Type SymbolicLink $WindowsTerminalPath\settings.json -Value $env:USERPROFILE\.dotfiles\WindowsTerminal\settings.$env:COMPUTERNAME.json
    }

    # Vscode
    $VscodePath = "$env:USERPROFILE\AppData\Roaming\Code\User"
    if (-Not (Test-Path ("$VscodePath\settings.json"))) {
        New-Item -Type SymbolicLink $VscodePath\settings.json -Value $env:USERPROFILE\.dotfiles\vscode\settings.json
    } elseif (-Not ((Get-Item ("$VscodePath\settings.json")).Attributes.ToString() -match "ReparsePoint")) {
        copy $VscodePath\settings.json $VscodePath\settings.json.bak
        rm $VscodePath\settings.json
        New-Item -Type SymbolicLink $VscodePath\settings.json -Value $env:USERPROFILE\.dotfiles\vscode\settings.json
    }
    if (-Not (Test-Path ("$VscodePath\keybindings.json"))) {
        New-Item -Type SymbolicLink $VscodePath\keybindings.json -Value $env:USERPROFILE\.dotfiles\vscode\keybindings.json
    } elseif (-Not ((Get-Item ("$VscodePath\keybindings.json")).Attributes.ToString() -match "ReparsePoint")) {
        copy $VscodePath\keybindings.json $VscodePath\keybindings.json.bak
        rm $VscodePath\keybindings.json
        New-Item -Type SymbolicLink $VscodePath\keybindings.json -Value $env:USERPROFILE\.dotfiles\vscode\keybindings.json
    }
}
