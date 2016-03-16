wifi.setmode(wifi.STATION)
wifi.sta.config()
print(wifi.sta.getip())

function getWpath(address, port, path)
  if conn_busy == false or conn_busy == nil then
    conn_busy = true
    local conn=net.createConnection(net.TCP, 0)

    conn:on("receive", function(conn, payload)
      if (DEBUG) then print("received") end
      if string.len(payload) < 1460 then conn:close() end
      print(payload)
    end)

    if (DEBUG) then
      conn:on("reconnection", function(conn)
        print("reconnected")
      end)

      conn:on("disconnection", function(conn)
        print("disconnected")
        conn_busy = false
      end)

      conn:on("sent", function(conn)
        print("sent")
      end)
    end

    conn:on("connection", function(conn) 
      if (DEBUG) then print("connected") end
      conn:send("GET /"..path.." HTTP/1.1\r\n"
      .. "Host: " .. address .. "\r\n"
      .. "Connection: close\r\n"
      .. "User-Agent: NodeMCU-" .. node.chipid() .. "\r\n"
      .. "\r\n")
    end)

    conn:connect(port, address)
  end
end

getWpath('www.arjunnaik.in', 80, '/')
