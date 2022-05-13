restart -force -nowave
add wave -hex Op Data
add wave Clock Reset_n
add wave SDA SCL Completed
add wave -unsigned state

force Clock 1 0, 0 10 -repeat 20

force Reset_n 0
run 40

force Reset_n 1
force Op 'h0
run 40

force Data 8'b10101010
force Op 'h1
run 580

force Data 8'b00001111
force Op 'h2
run 540

force Data 8'b01010101
force Op 'h3
run 660

force Data 8'b00000000
force Op 'h0
run 120

view wave
