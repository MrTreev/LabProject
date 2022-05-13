restart -force -nowave
add wave Start Clock Reset_n
add wave -hex op data
add wave SDA SCL

force Clock 1 0, 0 10 -repeat 20

force Reset_n 0
force Start 0
run 40

force Reset_n 1
run 40

force Start 1 0, 0 40
run 18000

view wave
