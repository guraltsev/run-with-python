pythonExe := "python"

; Main script execution
args := A_Args
scriptPath := ""

if (args.Length < 1) {
    ; Show file selection dialog if no argument is provided
    ExitApp
	fileDialog := FileSelect("1", A_WorkingDir ,"Please select a Python script to run.","Python Script (*.py)|*.py")
    if (fileDialog == "") {
        ; MsgBox("No file selected. Exiting.", "Operation Cancelled", 64)
        ExitApp
    }
    scriptPath := fileDialog
} else {
    scriptPath := args[1]
}

; Verify the file exists
if !FileExist(scriptPath) {
    MsgBox("The specified Python script was not found:`n" . scriptPath )
    ExitApp
}

; Define the Python command
pythonCommand := pythonExe . " `"" . scriptPath . "`""

; Run the Python script
RunWait(A_ComSpec . " /c " . pythonCommand . " & pause ",)

ExitApp