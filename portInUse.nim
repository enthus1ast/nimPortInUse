#include <boost/asio.hpp>
#include <iostream>
import net 

proc portInUse*(port: int, address = "", protocol = IPPROTO_TCP, sockType = SOCK_STREAM): bool =
  ## if port in use, return `true`; else return `false`
  ## this functions also returns true if caller is not allowed to bind to given port
  ## so testing ports below 1024 must be often done as root.
  # let domain = 
  # let sockType: SockType = SOCK_STREAM if protocol == IPPROTO_TCP elif IP

  var socket = newSocket(protocol = protocol, sockType = sockType)
  socket.setSockOpt(OptReuseAddr, true)
  try:
    socket.bindAddr(port.Port, address)
    result = false
  except:
    result = true
  socket.close()

when isMainModule:
  for port in 1024..40_048:
    if portInUse(port, "127.0.0.1", IPPROTO_TCP):
        echo  "TCP Port " , port , " is in use";
    if portInUse(port, "127.0.0.1", IPPROTO_UDP, SOCK_DGRAM):
        echo  "UDP Port " , port , " is in use";