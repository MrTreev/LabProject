### ------------------------------------------------------------------------------------------------------------------------ ###

set step 10

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simAddressDecoder {} {
	restart -force -nowave

	change P_RegCount 8

	# Add waves
	add wave -color #00ff00 -hex In_Address
	add wave -color #00ff00 -bin In_Enable
	add wave -color #0000ff -hex Out_DecodedAddress

	# Sim
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simClockDivider {div} {
	restart -force -nowave

	# Add waves
	add wave -color #00ff00 -bin clk_in
	add wave -color #00ff00 -bin reset_n
	add wave -color #ff0000 -hex counter_value
	add wave -color #0000ff -bin clk_out

	# Reset

	# Sim
	force clk_in 1 0, 0 10 -repeat 20

	force reset_n 1
	run [expr $div*50]
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simI2CController {} {
	restart -force -nowave
	# Add waves
	add wave -color #00ff00 -hex Data
	add wave -color #00ff00 -hex Op
	add wave -color #00ff00 -bin Clock
	add wave -color #00ff00 -bin Reset_n
	add wave -color #ffff00 -hex SDA
	add wave -color #0000ff -hex SCL
	add wave -color #0000ff -bin Completed

	# Configure Clocks
	force Clock 1 0, 0 10 -repeat 20

	# Reset
    force Reset_n 0
    run 40

	# Sim
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
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simI2CDataFeed {} {
	restart -force -nowave
	# Add waves
	add wave -color #00ff00 -bin Update
	add wave -color #00ff00 -bin Reset_n
	add wave -color #ff0000 -hex state
	add wave -color #0000ff -hex Op
	add wave -color #0000ff -hex Data

	# Configure Clocks
	force Update 1 0, 0 10 -repeat 20

	# Reset
	force Reset_n 0
	run 40

	# Sim
	force Reset_n 1
	run 680
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simI2CSubsystem {} {
	restart -force -nowave
	# Add waves
	add wave -color #00ff00 -bin Start
	add wave -color #00ff00 -bin Clock
	add wave -color #00ff00 -bin Reset_n
	add wave -color #ff0000 -bin controller_completed
	add wave -color #ff0000 -bin update_data
	add wave -color #ff0000 -hex data
	add wave -color #ff0000 -hex op
	add wave -color #ffff00 -hex SDA
	add wave -color #0000ff -hex SCL

	# Configure Clocks
	force Clock 1 0, 0 10 -repeat 20

	# Reset
	force Reset_n 0
	force Start 0
	run 40

	# Sim
	force Reset_n 1
	run 40

	force Start 1 0, 0 40
	run 18000
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simPixelCursor {} {
	restart -force -nowave
	# Add waves
	add wave -color #00ff00 -bin pix_clk
	add wave -color #00ff00 -bin reset_n
	add wave -color #0000ff -hex hcount
	add wave -color #0000ff -hex vcount
	add wave -color #0000ff -bin active
	add wave -color #0000ff -bin hsync
	add wave -color #0000ff -bin vsync

	# Configure Clocks
	force pix_clk 1 0ns, 0 19.84ns -repeat 39.68ns

	# Reset
	force reset_n 0
	run 100ns

	# Sim
	force reset_n 1
	run 20ms
}

### ------------------------------------------------------------------------------------------------------------------------ ###

proc simPixelAddr {} {

	# Source PixelAddr, Reset Waveform, Setup Runtime
	vsim work.PixelAddr
	restart -force -nowave
	set runtime 0
	global step

	# Add waves
	add wave -color #00ff00 -unsigned offset
	add wave -color #00ff00 -unsigned xpos
	add wave -color #00ff00 -unsigned ypos
	add wave -color #ff0000 -unsigned addr
	add wave -color #0000ff -unsigned address

	force offset 0
	force xpos 0
	force ypos 0

	run $step

	for {set a 1} {$a < 525} {incr a} {
		force ypos 10#$a $runtime
		for {set b 1} {$b < 800} {incr b} {
			force xpos 10#$b $runtime
			set runtime [expr $runtime + $step]
		}
	}
	run $runtime
	view wave
}

### ------------------------------------------------------------------------------------------------------------------------ ###
