# 🛠️ Prerequisites:
# ----------------------------------------------------------
# 1. The target machines must be reachable over the network.
# 2. WinRM (Windows Remote Management) must be enabled on the client machines.
#    - You can enable it locally using: Enable-PSRemoting -Force
# 3. The firewall must allow inbound traffic on port 5985 (HTTP for WinRM).
# 4. The machines must allow PowerShell remote connections.
# 5. Your account must have administrative rights on the target machines.
# ----------------------------------------------------------

# 💻 List of target computers (replace with actual hostnames)
$computers = @(
    "EMP01",
    "LTP01",
    "EMP02",
    "LTP02"
    # Add the rest of the 200 machine names here
)

# 🔁 Loop through each computer to run gpupdate and restart
foreach ($computer in $computers) {
    Write-Host "Connecting to $computer..." -ForegroundColor Cyan
    try {
        # 📡 Remote connection using PowerShell Remoting
        Invoke-Command -ComputerName $computer -ScriptBlock {
            # 🔄 Force group policy update
            gpupdate /force

            # 🔁 Restart the computer after applying policies
            Restart-Computer -Force
        } -ErrorAction Stop

        Write-Host "✔️ $computer updated and restarting." -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to connect to $computer: $_" -ForegroundColor Red
    }
}
