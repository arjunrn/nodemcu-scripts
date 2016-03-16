socket = require("socket")

function receive(connection)
  return connection:receive(2^10)
end

c = assert(socket.connect("74.125.136.121", 80))
c:send("GET / HTTP/1.0\r\n\r\n")
local count = 0
while true do
  local s, status = receive(c)
  print(s)
  print("Statuss")
  print(status)
  if status == "closed" then
    break
  else
      count = count + string.len(s)
  end
end
c:close()
