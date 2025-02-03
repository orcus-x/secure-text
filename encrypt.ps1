Add-Type -AssemblyName System.Windows.Forms

# Fixed secure key (must be 32 characters for AES)
$secureKey = "YourVerySecureFixedKey1234567890"  # Replace with your secure 32-character key
$secureIV = "1234567890123456"  # 16-byte IV for AES

# Function to encrypt text
function Encrypt-Text {
    param (
        [string]$plainText
    )
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = [System.Text.Encoding]::UTF8.GetBytes($secureKey)
    $aes.IV = [System.Text.Encoding]::UTF8.GetBytes($secureIV)

    $encryptor = $aes.CreateEncryptor()
    $plainBytes = [System.Text.Encoding]::UTF8.GetBytes($plainText)
    $encryptedBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)

    return [Convert]::ToBase64String($encryptedBytes)
}

# GUI to get user input
$form = New-Object System.Windows.Forms.Form
$form.Text = "Enter Text to Encrypt"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter text to encrypt:"
$label.Location = New-Object System.Drawing.Point(10,10)
$label.AutoSize = $true
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Width = 360
$form.Controls.Add($textBox)

$buttonOK = New-Object System.Windows.Forms.Button
$buttonOK.Text = "Encrypt & Save"
$buttonOK.Location = New-Object System.Drawing.Point(10,80)
$buttonOK.Width = 120  # Increased button width for better UI
$buttonOK.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.Controls.Add($buttonOK)

$form.AcceptButton = $buttonOK

if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $userText = $textBox.Text
    if ($userText -ne "") {
        # Encrypt the entered text
        $encryptedText = Encrypt-Text -plainText $userText

        # Get script directory (handles both script and compiled EXE)
        if ($MyInvocation.MyCommand.Path) {
            $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
        } else {
            $scriptPath = [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
        }

        $keyFile = Join-Path $scriptPath "key.dat"

        # Save encrypted text to key.dat
        Set-Content -Path $keyFile -Value $encryptedText

        [System.Windows.Forms.MessageBox]::Show("Encrypted text saved successfully!", "Success")
    } else {
        [System.Windows.Forms.MessageBox]::Show("No text entered. Process aborted.", "Error")
    }
}
