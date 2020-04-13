@echo off

set DOTFILES_PATH=.
set VSCODE_PATH=%HOMEPATH%\AppData\Roaming\Code\User
FOR /D %%a IN (%HOMEPATH%\AppData\Local\Packages\Microsoft.WindowsTerminal_*) DO set WINDOWS_TERNAL_PATH=%%a\LocalState

rem Windows Terminal profiles.json
del %WINDOWS_TERNAL_PATH%\profiles.json
mklink %WINDOWS_TERNAL_PATH%\profiles.json %DOTFILES_PATH%\WindowsTerminal\profiles.json

rem VSCode
del %VSCODE_PATH%\settings.json
mklink %VSCODE_PATH%\settings.json %DOTFILES_PATH%\vscode\settings.json
del %VSCODE_PATH%\keybindings.json
mklink %VSCODE_PATH%\keybindings.json %DOTFILES_PATH%\vscode\keybindings.json