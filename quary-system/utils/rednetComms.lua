-- /utils/rednetComms.lua

-- Broadcast message to the hub
function rednetComms.broadcast(message, protocol)
    rednet.broadcast(message, protocol)
    print("📡 Broadcasted message: " .. textutils.serialize(message))
  end
  
  -- Send a message to a specific ID
  function rednetComms.sendMessage(id, message, protocol)
    rednet.send(id, message, protocol)
    print("📡 Sent message to ID " .. id .. ": " .. textutils.serialize(message))
  end
  
  -- Receive a message
  function rednetComms.receiveMessage(protocol, timeout)
    local id, message = rednet.receive(protocol, timeout)
    return id, message
  end
  
  return rednetComms  