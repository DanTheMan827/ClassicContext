; The name of the installer
Name "ClassicContext"

; The file to write
OutFile "ClassicContext.exe"

; The default installation directory
InstallDir "$LOCALAPPDATA\Packages\DanTheMan827.ClassicContext"

; Registry key to check for directory (so if you install again, it will overwrite the old one automatically)
InstallDirRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "InstallLocation"

; Request application privileges for Windows Vista
RequestExecutionLevel user

; Show details
ShowInstDetails show

; Plugins
!addplugindir .\Plugins

; Installer compression
SetCompressor /FINAL /SOLID lzma

; Pages
Page components
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

; The stuff to install
Section "ClassicContext"
  SetShellVarContext all
  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

  ; Create the installation directory.
  CreateDirectory "$INSTDIR"

  ; Write the installation path into the registry
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "InstallLocation" "$INSTDIR"

  ; Write the uninstall keys for Windows
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "DisplayName" "Classic Context"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "Publisher" "DanTheMan827"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "URLInfoAbout" "https://github.com/DanTheMan827/ClassicContext"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "HelpLink" "https://github.com/DanTheMan827/ClassicContext"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "URLUpdateInfo" "https://github.com/DanTheMan827/ClassicContext/releases"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "DisplayIcon" "%WINDIR%\explorer.exe"
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "NoModify" 1
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

  ; Disable the Windows 11 style context menu
  SetRegView 64
  WriteRegStr HKCU "Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "" ""

  ; Restart explorer
  ExecWait "taskkill.exe /F /IM explorer.exe"
  Sleep 500
  nsRestartExplorer::nsRestartExplorer start infinite

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  SetShellVarContext all

  ; Remove registry keys
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\DTM-ClassicContext"

  SetRegView 64
  DeleteRegKey HKCU "Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"

  ; Restart explorer
  ExecWait "taskkill.exe /F /IM explorer.exe"
  Sleep 500
  nsRestartExplorer::nsRestartExplorer start infinite

  RMDir /r "$INSTDIR"

SectionEnd
