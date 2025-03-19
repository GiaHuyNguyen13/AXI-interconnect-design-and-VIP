clean:
	rm -r *.d 

run:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

wave:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

cov:
	simvision ./cov_work/scope/test/icc_06d2eb86_5d45b528.ucd


