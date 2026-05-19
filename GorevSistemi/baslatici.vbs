Set shell = CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
currentDir = fso.GetParentFolderName(WScript.ScriptPosition)
shell.CurrentDirectory = currentDir
shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & currentDir & "\motor.ps1""", 0, False