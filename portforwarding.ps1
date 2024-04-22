if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

$WSL2_IPV4=bash ~/get_ipv4.bash
$HOST_IPV4="Your host IP address"

netsh interface portproxy delete v4tov4 listenaddress=$HOST_IPV4 listenport=22
netsh interface portproxy delete v4tov4 listenaddress=$HOST_IPV4 listenport=8081
netsh interface portproxy delete v4tov4 listenaddress=$HOST_IPV4 listenport=3333
netsh interface portproxy delete v4tov4 listenaddress=$HOST_IPV4 listenport=3001

netsh interface portproxy add v4tov4 listenaddress=$HOST_IPV4 listenport=22   connectaddress=$WSL2_IPV4 connectport=22
netsh interface portproxy add v4tov4 listenaddress=$HOST_IPV4 listenport=8081 connectaddress=$WSL2_IPV4 connectport=8081
netsh interface portproxy add v4tov4 listenaddress=$HOST_IPV4 listenport=3333 connectaddress=$WSL2_IPV4 connectport=3333
netsh interface portproxy add v4tov4 listenaddress=$HOST_IPV4 listenport=3001 connectaddress=$WSL2_IPV4 connectport=3001
