import net, random 

proc portInUse*(port: int, address = "", protocol = IPPROTO_TCP, sockType = SOCK_STREAM): bool =
  ## if port is in use, return `true`; else return `false`
  ## this functions also returns true if caller is not allowed to bind to given port
  ## so testing ports below 1024 must often be done as root.
  var socket = newSocket(protocol = protocol, sockType = sockType)
  try:
    socket.bindAddr(port.Port, address)
    result = false
  except:
    result = true
  socket.close()

proc getFreePort(): Port = 
  while true:
    let candidate = rand(1024..65535)
    if not portInUse(candidate): return Port candidate

when isMainModule:
  for port in 1024..high(Port).int:
    if portInUse(port, "127.0.0.1", IPPROTO_TCP):
        echo  "TCP Port " , port , " is in use";
    if portInUse(port, "127.0.0.1", IPPROTO_UDP, SOCK_DGRAM):
        echo  "UDP Port " , port , " is in use";
