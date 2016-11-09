transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/krishna/Desktop/Toplevel/Ir_latch.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/Shifter.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/DataRegister.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/sixteen_bit_nand.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/Sign_Extender_by_7.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/memory.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/sixteen_bit_subtracter.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/controller.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/mux41.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/Components.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/RegFile.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/PriorityEncoder.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/mux81.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/Sign_Extender_by_10.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/sixteen_bit_adder.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/mux21.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/flag.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/final.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/ALU.vhd}
vcom -93 -work work {/home/krishna/Desktop/Toplevel/Datapath.vhd}

vcom -93 -work work {/home/krishna/Desktop/Toplevel/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
