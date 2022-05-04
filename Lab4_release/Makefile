all: cmp vvp

cmp:
	iverilog -o Simple_CPU.vvp *.v
vvp:
	vvp Simple_CPU.vvp -fst -sdf-verbose -lxt2
lxi:
	gtkwave Simple_CPU.lxt &

clean:
	@rm -rf Simple_CPU.vvp Simple_CPU.lxt Adder DM ALU_Ctrl Decoder MUX_2to1 Imm_Gen Data_Memory result.txt
