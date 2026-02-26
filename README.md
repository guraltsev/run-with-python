# run-with-python
AHK script to run a Python script with the default interpreter and keep the window open.

This AutoHotkey script runs a Python script with your default Python interpreter and pauses at the end so you can read output/errors.

## Installation and usage

1. Compile this script to an `.exe` file. To do this, use [Ahk2Exe](https://github.com/AutoHotkey/Ahk2Exe/releases) or install the full [AutoHotkey](https://autohotkey.com/) suite and compile from its launcher.
2. Right-click a Python script and choose `Open with...`.
3. Select `Look for another app on this PC` and choose the compiled `Python and Wait.exe`.
4. Double-click the Python script to run it.

## What this script does

- If `run-with-python.ini` exists with `python_path`, that interpreter is used and overrides all auto-detection.
- Otherwise, uses `py` when available, then falls back to `python`.
- Accepts a `.py` file path from Windows `Open with`.
- Forwards any extra command-line arguments to the Python script.
- Verifies the target script exists before running.
- Keeps the terminal open with `pause` so output can be read.


## Optional config file

Create `run-with-python.ini` beside the compiled executable to force a specific interpreter:

```ini
[run-with-python]
python_path=C:\Python311\python.exe
```

If the file exists and `python_path` is set, that path is used and PATH-based detection is skipped.

## Current design notes / limitations

- This launcher is Windows-only (AutoHotkey).
- It opens a console window for each run by design.
- It sets the working directory to the launched script's folder before starting Python.
- It does not currently support drag-and-drop multiple files in a single launch.

## Critique of this approach

This approach is intentionally simple and practical for local scripting, but there are trade-offs:

- **Good**: no registry edits, no custom shell extension, and very easy to distribute as one `.exe`.
- **Good**: explicit `pause` improves usability for scripts that exit quickly.
- **Risk**: behavior depends on PATH and Python launcher availability (`py`/`python`).
- **Risk**: console-focused UX can feel clunky for GUI-oriented Python scripts.

If you want a more robust long-term setup, consider:

- Associating `.py` with `py.exe` directly in Windows settings.
- Using a small PowerShell wrapper if you want richer logging or environment setup.
- Adding optional venv detection (e.g., prefer `.venv\\Scripts\\python.exe` near the script).
