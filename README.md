# dotfiles

## PowerShell からワンライナーでインストールする手順

```powershell
Invoke-Expression (new-object net.webclient).downloadstring("https://raw.github.com/n0n0r1/dotfiles/master/bin/install.ps1")
```

## vscode の拡張機能インストール方法

```powershell
Get-Content extensions | % { code --install-extension $_ }
```
