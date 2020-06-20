# dotfiles

## PowerShell からワンライナーでインストールする手順

```powershell
Invoke-Command -ScriptBlock ([scriptblock]::Create((new-object net.webclient).downloadstring("https://raw.github.com/n0n0r1/dotfiles/master/bin/dotfiles.ps1"))) -ArgumentList "i"
```

## vscode の拡張機能インストール方法

```powershell
Get-Content extensions | % { code --install-extension $_ }
```
