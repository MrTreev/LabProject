restart -force -nowave
add wave clk_in clk_out reset_n
add wave -hex counter_value

force clk_in 1 0, 0 10 -repeat 20

force reset_n 1
run 400

view wave
