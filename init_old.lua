a = true
-- setup I2c and connect display
function init_i2c_display()
     sla = 0x3c
     i2c.setup(0, 5, 6, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end
-- the draw() routine
function draw()
   ip = wifi.sta.getip()
   if ip == nil then
    ip = "Not assigned"
   end
   disp:setFont(u8g.font_6x10)
   disp:drawStr( 30, 10, "Hello IoT!")
   disp:drawLine(0, 25, 128, 25);
   disp:setFont(u8g.font_chikita)
   disp:drawStr( 5, 40, "Arjun NAIK")
   disp:drawStr( 5, 50, ip)
end

function display()
  disp:firstPage()
  repeat
    draw()
  until disp:nextPage() == false
  disp:nextPage()
end

wifi.setmode(wifi.STATION)
wifi.sta.config(,)
init_i2c_display()
display()
