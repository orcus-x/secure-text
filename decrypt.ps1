# Fixed secure key (must be 32 characters for AES)
$secureKey = "YourVerySecureFixedKey1234567890"  # Replace with your secure 32-character key
$secureIV = "1234567890123456"  # 16-byte IV for AES

# Function to decrypt text
function Decrypt-Text {
    param (
        [string]$encryptedText
    )
    try {
        $aes = [System.Security.Cryptography.Aes]::Create()
        $aes.Key = [System.Text.Encoding]::UTF8.GetBytes($secureKey)
        $aes.IV = [System.Text.Encoding]::UTF8.GetBytes($secureIV)

        $decryptor = $aes.CreateDecryptor()
        $encryptedBytes = [Convert]::FromBase64String($encryptedText)
        $plainBytes = $decryptor.TransformFinalBlock($encryptedBytes, 0, $encryptedBytes.Length)

        return [System.Text.Encoding]::UTF8.GetString($plainBytes)
    } catch {
        Write-Host "Error: Unable to decrypt. Ensure the secure key and IV are correct."
        return $null
    }
}

# Determine the script path correctly in both PowerShell and compiled EXE mode
if ($MyInvocation.MyCommand.Path) {
    # If running as a PowerShell script
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
} else {
    # If running as a compiled EXE, use the assembly location
    $scriptPath = [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
}

$keyFile = Join-Path $scriptPath "key.dat"

# Read the encrypted contents of 'key.dat'
if (Test-Path $keyFile) {
    $encryptedText = Get-Content -Path $keyFile -Raw
    $decryptedText = Decrypt-Text -encryptedText $encryptedText

    if ($decryptedText) {
        # Copy to clipboard
        $decryptedText | Set-Clipboard
        Write-Host "Decrypted text copied to clipboard successfully!"
    }
} else {
    Write-Host "Error: 'key.dat' file not found in $scriptPath!"
    Pause
}
