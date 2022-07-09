$wsl2IP = bash -c "ip addr show eth0 | grep -w inet | awk '{print `\`$2}' |sed 's/`\`\/.*//'"
 
if( $wsl2IP ) {
} else {
  echo "The ip address of WSL 2 cannot be found";
  exit;
}

#[Ports]
 
#All the ports you want to forward separated by coma
$ports=@(5432,8181);
 
 
#[Static ip]
#You can change the addr to your ip config to listen to a specific address
$listenAddr='0.0.0.0';
$portsList = $ports -join ",";
 
 
#Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";
 
for( $i = 0; $i -lt $ports.length; $i++ ){
  $port = $ports[$i];
  iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$listenAddr";
}