# `WINDOWS`

## Install History

If the install fails, try removing `--architecture arm64` from the below:

```powershell
sudo winget install --architecture arm64 --verbose --accept-package-agreements --accept-source-agreements 'Rustlang.Rustup' 'Microsoft.VisualStudioCode' 'Microsoft.VisualStudioCode.Insiders' 'Microsoft.WindowsSDK.10.0.28000' 'Microsoft.VisualStudio.2022.BuildTools' 'WhatsApp.WhatsApp' 'WhatsApp.WhatsApp.Beta' 'Element.Element' 'Telegram.TelegramDesktop' 'Microsoft.PowerToys' 'Google.PlatformTools' 'Google.AndroidStudio' 'Google.AndroidCLI' 'Google.AndroidGPUInspector' 'tailscale.tailscale' 'Mozilla.Firefox' 'Google.Chrome' 'Microsoft.Sysinternals.Suite' 'Microsoft.WinDbg'
```