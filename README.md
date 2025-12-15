# BusyBox Windows Hardlink Setup

A batch script to set up BusyBox on Windows and generate `.exe` files for all applets using hard links.

---

## What this does

* Creates a `bin` directory under your user profile
* Downloads `busybox.exe` (if not already present)
* Enumerates all available BusyBox applets
* Creates hard-linked `<applet>.exe` files for each applet
* Adds the `bin` directory to your `PATH`

After running the script, you can use BusyBox applets as if they were native Windows commands.

---

## Requirements

* Windows (NTFS filesystem required for hard links)
* No administrator privileges required in most environments (hard links can be created by normal users on NTFS)
* PowerShell available in PATH (for download)

---

## Usage

1. Clone this repository or download the batch file
2. Open **Command Prompt as Administrator**
3. Run the script:

```bat
busybox_setup.bat
```

That’s it. The setup is fully automated.

---

## Files and paths

* BusyBox binary:

  ```
  %USERPROFILE%\bin\busybox.exe
  ```
* Generated commands:

  ```
  %USERPROFILE%\bin\<applet>.exe
  ```
* Log file:

  ```
  %USERPROFILE%\bin\busybox_setup.log
  ```

---

## Notes

* Existing `<applet>.exe` files in the `bin` directory will be removed and recreated
* The script is safe to run multiple times
* No administrator privileges are required in most environments
* If hard link creation fails, re-run the script from an **elevated (Administrator) Command Prompt**
* The repository does **not** include BusyBox itself

BusyBox is licensed under **GPLv2**.

---

## License

This script is licensed under the **MIT License**.

See the `LICENSE` file for details.
