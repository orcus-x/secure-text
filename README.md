# Secure Text Encryption & Decryption with PowerShell

## Overview

This PowerShell script provides a simple GUI-based method to encrypt and decrypt text using AES encryption. The script ensures secure storage of sensitive information by encrypting input text and saving it to a file (`key.dat`). It also allows decryption of the stored data and automatically copies it to the clipboard.

## Features

- AES encryption using a fixed secure key and IV.
- Graphical User Interface (GUI) for user-friendly text input.
- Securely saves the encrypted text in a file.
- Decrypts the stored text and copies it to the clipboard.
- Supports execution as a PowerShell script or as a standalone executable.

## Prerequisites

- PowerShell 5.1 or later
- `Add-Type -AssemblyName System.Windows.Forms` must be supported.

## Installation & Usage

### Encrypting Text

1. Run the `encrypt.ps1` script.
2. Enter the text you want to encrypt in the popup window.
3. Click "Encrypt & Save" to store the encrypted text in `key.dat`.

### Decrypting Text

1. Run the `decrypt.ps1` script.
2. The script reads the `key.dat` file, decrypts its contents, and copies the plaintext to the clipboard.
3. Paste the decrypted text wherever needed.

## Installing ps2exe

To convert PowerShell scripts into standalone executables, you need to install `ps2exe`. You can install it from the PowerShell Gallery by running the following command:

```powershell
Install-Module ps2exe -Scope CurrentUser
```

If prompted, confirm the installation by typing `Y`.

## Creating Executable Files

To create standalone executable files from the PowerShell scripts, use:

```powershell
ps2exe encrypt.ps1 -NoConsole -NoOutput
ps2exe decrypt.ps1 -NoConsole -NoOutput
```

This will generate `encrypt.exe` and `decrypt.exe` that can be run independently without requiring PowerShell.

## Important Notes

- **Security Warning**: The AES key and IV are hardcoded for demonstration purposes. For real-world applications, use a more secure key management system.
- Ensure that `key.dat` is stored securely and is not accessible by unauthorized users.
- The encryption method is AES-256 with a 32-character key and a 16-byte IV.

## License

This project is released under the MIT License. Feel free to modify and enhance the script according to your needs.

## Author

Developed by [Orcus X].

