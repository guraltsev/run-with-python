pythonExe := ""

; Main script execution
args := A_Args
scriptPath := ""
scriptArgs := []

if (args.Length < 1) {
    ; Show file selection dialog if no argument is provided
    fileDialog := FileSelect("1", A_WorkingDir, "Please select a Python script to run.", "Python Script (*.py)|*.py")
    if (fileDialog = "") {
        ExitApp
    }
    scriptPath := fileDialog
} else {
    scriptPath := args[1]
    if (args.Length > 1) {
        Loop args.Length - 1 {
            scriptArgs.Push(args[A_Index + 1])
        }
    }
}

; Verify the file exists
if !FileExist(scriptPath) {
    MsgBox("The specified Python script was not found:`n" . scriptPath)
    ExitApp
}

pythonExe := ResolvePythonCommand()
if (pythonExe = "") {
    MsgBox("No Python interpreter was found. Configure run-with-python.ini or add Python to PATH.")
    ExitApp
}

pythonCommand := QuoteArg(pythonExe) . " " . QuoteArg(scriptPath)
for arg in scriptArgs {
    pythonCommand .= " " . QuoteArg(arg)
}

; Run the Python script and keep the terminal open
RunWait(A_ComSpec . " /c \"" . pythonCommand . " & echo. & pause\"")

ExitApp

QuoteArg(value) {
    escaped := StrReplace(value, '"', '""')
    return '"' . escaped . '"'
}

ResolvePythonCommand() {
    configuredPython := ReadConfiguredPython()
    if (configuredPython != "") {
        if !FileExist(configuredPython) {
            MsgBox("Configured Python path in run-with-python.ini does not exist:`n" . configuredPython)
            ExitApp
        }
        return configuredPython
    }

    if (GetCommandPath("py.exe") != "") {
        return "py"
    }

    if (GetCommandPath("python.exe") != "") {
        return "python"
    }

    return ""
}

ReadConfiguredPython() {
    iniPath := A_ScriptDir . "\\run-with-python.ini"
    if !FileExist(iniPath) {
        return ""
    }

    configuredPython := IniRead(iniPath, "run-with-python", "python_path", "")
    return Trim(configuredPython)
}

GetCommandPath(commandName) {
    shell := ComObject("WScript.Shell")
    try {
        return shell.Exec("where " . commandName).StdOut.ReadAll()
    } catch {
        return ""
    }
}
