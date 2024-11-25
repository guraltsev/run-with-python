# run-with-python
AHK script to run a python script with the default interpreter

This AutoHotkey script runs a Python script with the default Python interpreter.

When you double click on a Python script, Windows will usually open it in a text editor. This script allows you to double click on a Python script and have it run with the default Python interpreter.

The script will also pause the command prompt window after it runs the script so you can see the output. 

## Installation and usage

1. Compile this script to an `.exe` file. To do this, using the [AHK2exeompiler](https://github.com/AutoHotkey/Ahk2Exe/releases). You can also download the full [AutoHotkey](https://autohotkey.com/) suite and use the launcher for a GUI interface to the compiler. You can use the included python icon for your binary. 


2. Right-click on a Python script and choose `Open with...` from the context menu. Select `Look for another app on this PC` and enter the path to the compiled `Python and Wait.exe`.

3. Double click on the Python script to run it with the default Python interpreter.