.PHONY: comp lint sim run wave

MODULE=init

comp:
	iverilog -g2012 -s $(MODULE)_tb -o project3.vvp -c Filelist.txt

lint:
	iverilog -g2012 -s axi_interconnect -o project3.vvp -c Filelist.txt
	
sim:
	vvp project3.vvp

run:
	make comp && make sim

wave:
	gtkwave