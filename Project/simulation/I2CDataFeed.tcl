restart -force -nowave
add wave Update Reset_n
add wave -hex Op Data
add wave -unsigned state

force Update 1 0, 0 10 -repeat 20

force Reset_n 0
run 40

force Reset_n 1
run 680

view wave
