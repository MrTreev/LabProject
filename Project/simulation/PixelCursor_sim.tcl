restart -force -nowave
add wave pix_clk reset_n active hsync vsync
add wave -dec hcount vcount

force pix_clk 1 0ns, 0 19.84ns -repeat 39.68ns

force reset_n 0
run 100ns

force reset_n 1
run 20ms

view wave
