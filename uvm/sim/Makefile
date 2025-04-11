
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

run_test:
	@echo "Running test ID $(ID)..."
	@test_name=$$(sed -n "$$(( $(ID) ))p" $(TEST_LIST_FILE)); \
	echo "Test name: $$test_name"; \
	make clean; \
	xrun -f filelist.f -top tb -timescale 1ns/1ps +TEST_SEL="$$test_name" +define+UVM_NO_DPI +UVM_VERBOSITY=UVM_HIGH -access +rwc

regression:
	@echo "Running regression from ID $(FROM) to ID $(TO)..."
	@errors=0; \
	for id in $(shell seq $(FROM) $(TO)); do \
		test_name=$$(sed -n "$${id}p" $(TEST_LIST_FILE)); \
		echo -e "\n"; \
		echo "==============================="; \
		echo "Running Test ID $$id: $$test_name"; \
		echo "==============================="; \
		make run_test ID=$$id > run_$$id.log 2>&1; \
		uvm_errs=$$(grep "UVM_ERROR" run_$$id.log | tail -1 | awk '{print $$3}'); \
		echo "UVM_ERROR Count: $$uvm_errs"; \
		errors=$$((errors + uvm_errs)); \
	done; \
	echo "==============================="; \
	echo "Total UVM_ERRORs in Regression: $$errors"; \
	echo "==============================="
