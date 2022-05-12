restart -force -nowave
add wave -hex Data
add wave Enable Clock Reset_n
add wave SDA SCL Ack
add wave -unsigned state

force Clock 1 0, 0 10 -repeat 20

force Reset_n 0
run 40

force Reset_n 1
force Enable 0
run 40

force Data 8'b10101010
force Enable 1
run 1000

force Enable 0
run 1000

view wave
