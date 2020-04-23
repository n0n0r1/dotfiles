@echo off

set DOTFILES_PATH=%~dp0\..\
set VSCODE_PATH=%USERPROFILE%\AppData\Roaming\Code\User
FOR /D %%a IN (%USERPROFILE%\AppData\Local\Packages\Microsoft.WindowsTerminal_*) DO set WINDOWS_TERNAL_PATH=%%a\LocalState

rem Windows Terminal profiles.json
if exist %DOTFILES_PATH%\WindowsTerminal\profiles.%COMPUTERNAME%.json (
    del %WINDOWS_TERNAL_PATH%\profiles.json
    mklink %WINDOWS_TERNAL_PATH%\profiles.json %DOTFILES_PATH%\WindowsTerminal\profiles.%COMPUTERNAME%.json
) else (
    copy %WINDOWS_TERNAL_PATH%\profiles.json %DOTFILES_PATH%\WindowsTerminal\profiles.%COMPUTERNAME%.json
    del %WINDOWS_TERNAL_PATH%\profiles.json
    mklink %WINDOWS_TERNAL_PATH%\profiles.json %DOTFILES_PATH%\WindowsTerminal\profiles.%COMPUTERNAME%.json
)

rem VSCode
copy %VSCODE_PATH%\settings.json %VSCODE_PATH%\settings.json.bak
del %VSCODE_PATH%\settings.json
mklink %VSCODE_PATH%\settings.json %DOTFILES_PATH%\vscode\settings.json

copy %VSCODE_PATH%\keybindings.json %VSCODE_PATH%\keybindings.json.bak
del %VSCODE_PATH%\keybindings.json
mklink %VSCODE_PATH%\keybindings.json %DOTFILES_PATH%\vscode\keybindings.json