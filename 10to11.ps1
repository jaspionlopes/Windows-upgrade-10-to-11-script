Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Função para aplicar o bypass
function Apply-Bypass {
    $regPath = "HKLM:\SYSTEM\Setup\LabConfig"
    If (-Not (Test-Path $regPath)) {New-Item -Path $regPath -Force | Out-Null}

    New-ItemProperty -Path $regPath -Name "BypassTPMCheck" -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "BypassCPUCheck" -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "BypassRAMCheck" -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "BypassSecureBootCheck" -Value 1 -PropertyType DWord -Force | Out-Null
}

# Função para montar ISO e rodar setup
function Process-ISO($isoPath) {
    try {
        $mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
        Start-Sleep -Seconds 2

        $driveLetter = ($mountResult | Get-Volume).DriveLetter
        if ($driveLetter) {
            $SetupPath = "$driveLetter`:\setup.exe"
            if (Test-Path $SetupPath) {
                Apply-Bypass
                [System.Windows.Forms.MessageBox]::Show("Starting Windows11 Upgrade...","Starting",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
                Start-Process -FilePath $SetupPath -ArgumentList "/auto upgrade /dynamicupdate disable /eula accept /product server" -Wait
            } else {
                [System.Windows.Forms.MessageBox]::Show("setup.exe not found on ISO.","Erro",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
            }
        } else {
            [System.Windows.Forms.MessageBox]::Show("Not able to mount ISO.","Erro",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Mount error on ISO: $_","Erro",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
    }
}

# Criando a janela principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Upgrade Windows 10 to 11 - Jaspion"
$form.Size = New-Object System.Drawing.Size(400,180)
$form.StartPosition = "CenterScreen"
$form.BackColor = 'White'

# Botão para abrir ISO
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Text = "Select ISO file"
$buttonBrowse.Size = New-Object System.Drawing.Size(150,50)
$buttonBrowse.Location = New-Object System.Drawing.Point(125,50)
$buttonBrowse.BackColor = "LightBlue"
$form.Controls.Add($buttonBrowse)

# Evento do botão
$buttonBrowse.Add_Click({
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Filter = "ISO Files (*.iso)|*.iso"
    $fileDialog.Title = "Select Windows 11 ISO"

    if ($fileDialog.ShowDialog() -eq "OK") {
        Process-ISO $fileDialog.FileName
    }
})

[System.Windows.Forms.Application]::Run($form)
