transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Ayush\ Sinha/Desktop/Soda\ Dispenser {C:/Users/Ayush Sinha/Desktop/Soda Dispenser/sodadispenser.sv}

