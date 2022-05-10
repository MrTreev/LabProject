set_global_assignment -entity "PLLPixelClock" -library "lib_PLLPixelClock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLLPixelClock" -library "lib_PLLPixelClock" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "PLLPixelClock" -library "lib_PLLPixelClock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLLPixelClock" -name SPD_FILE [file join $::quartus(sip_path) "PLLPixelClock.spd"]

set_global_assignment -library "lib_PLLPixelClock" -name MISC_FILE [file join $::quartus(sip_path) "PLLPixelClock_sim/PLLPixelClock.vo"]
