transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {Final.vho}

vcom -93 -work work {/home/krishna/GIT/Toplevel/Testbench.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /dut=Final_vhd.sdo -L altera -L cycloneive -L gate_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
