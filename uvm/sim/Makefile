
TEST_LIST_FILE := testlist.txt

clean:
	rm -r *.d 

run:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

waveform:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc -gui

cov:
	simvision ./cov_work/scope/test/icc_06d2eb86_5d45b528.ucd

test1:
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +TEST_SEL="m1_write_s1_test" +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

test:
	@echo "Running test ID $(ID)..."
	@test_name=$$(sed -n "$$(( $(ID) ))p" $(TEST_LIST_FILE)); \
	echo "Test name: $$test_name"; \
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +TEST_SEL="$$test_name" +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

wave:
	@echo "Running test ID $(ID)..."
	@test_name=$$(sed -n "$$(( $(ID) ))p" $(TEST_LIST_FILE)); \
	echo "Test name: $$test_name"; \
	echo "sth">>here.d && make clean && \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +TEST_SEL="$$test_name" +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc -gui
