clean:
	rm -r *.d 

run:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

wave:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc -gui

cov:
	simvision ./cov_work/scope/test/icc_06d2eb86_5d45b528.ucd

run_test1:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -64 -uvmhome CDNS-1.1 case_pkg.sv -top tb -timescale 1ns/1ps +UVM_TESTNAME=m1_rd_s1__m2_rd_s2_test +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc
	#xrun -64 -uvmhome CDNS-1.2 test_pkg.sv tb_top.sv +UVM_TESTNAME=my_test	

