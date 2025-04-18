
// Import UVM classes
+incdir+../../../uvm-1.2/src
../../../uvm-1.2/src/uvm_pkg.sv

+incldir+../../../src
+incldir+../uvm_components

// Design
../../src/comparator.v
../../src/addr_decoder.v 
../../src/scu.v
../../src/rd_sl_return.v
../../src/wr_sl_return.v
../../src/axi_interconnect.v

// Interface
../uvm_components/axi_interface.sv

// Top tb
//../uvm_components/case_pkg.sv
../uvm_components/tb.sv

// Central memory
../uvm_components/central_mem.sv

// Master Agent
../uvm_components/master_agent/master_item.sv
../uvm_components/master_agent/master_gen_item_seq.sv
../uvm_components/master_agent/master_monitor.sv
../uvm_components/master_agent/master_rd_driver.sv
../uvm_components/master_agent/master_wr_driver.sv
../uvm_components/master_agent/master_agent.sv

// Slave Agent
../uvm_components/slave_agent/slave_item.sv
../uvm_components/slave_agent/slave_gen_item_seq.sv
../uvm_components/slave_agent/slave_monitor.sv
../uvm_components/slave_agent/slave_rd_driver.sv
../uvm_components/slave_agent/slave_wr_driver.sv
../uvm_components/slave_agent/slave_agent.sv

// Reference models
//../uvm_components/rd_ref_model.sv
//../uvm_components/wr_ref_model.sv

// Remaining UVM components
../uvm_components/scoreboard.sv
../uvm_components/env.sv
../uvm_components/base_test.sv
../uvm_components/burst_test.sv

// Testcase
../uvm_components/testcase/m1_write_s1_test.sv  
../uvm_components/testcase/m1_write_s2_test.sv  
../uvm_components/testcase/m1_read_s1_test.sv  
../uvm_components/testcase/m1_read_s2_test.sv  
../uvm_components/testcase/m2_write_s1_test.sv  
../uvm_components/testcase/m2_write_s2_test.sv  
../uvm_components/testcase/m2_read_s1_test.sv  
../uvm_components/testcase/m2_read_s2_test.sv  
../uvm_components/testcase/m1m2_wr_s1s2_test.sv  
../uvm_components/testcase/m1m2_rd_s1s2_test.sv  
../uvm_components/testcase/m1m2_wr_s2s1_test.sv  
../uvm_components/testcase/m1m2_rd_s2s1_test.sv  
../uvm_components/testcase/m1_wr_s1_m2_rd_s2_test.sv  
../uvm_components/testcase/m1_rd_s1_m2_wr_s2_test.sv  
../uvm_components/testcase/m1_wr_s2_m2_rd_s1_test.sv  
../uvm_components/testcase/m1_rd_s2_m2_wr_s1_test.sv  
../uvm_components/testcase/m1_wr_s1_m2_rd_s1_test.sv  
../uvm_components/testcase/m1_rd_s1_m2_wr_s1_test.sv  
../uvm_components/testcase/m1_wr_s2_m2_rd_s2_test.sv  
../uvm_components/testcase/m1_rd_s2_m2_wr_s2_test.sv  
../uvm_components/testcase/m1_rdwr_s1_m2_wr_s2_test.sv  
../uvm_components/testcase/m1_rdwr_s1_m2_rd_s2_test.sv  
../uvm_components/testcase/m1_rdwr_s2_m2_wr_s1_test.sv  
../uvm_components/testcase/m1_rdwr_s2_m2_rd_s1_test.sv  
../uvm_components/testcase/m1_wr_s1_m2_rdwr_s2_test.sv  
../uvm_components/testcase/m1_rd_s1_m2_rdwr_s2_test.sv  
../uvm_components/testcase/m1_wr_s2_m2_rdwr_s1_test.sv  
../uvm_components/testcase/m1_rd_s2_m2_rdwr_s1_test.sv  
../uvm_components/testcase/m1_rdwr_s1_test.sv  
../uvm_components/testcase/m1_rdwr_s2_test.sv  
../uvm_components/testcase/m2_rdwr_s1_test.sv  
../uvm_components/testcase/m2_rdwr_s2_test.sv  
../uvm_components/testcase/m1m2_wr_same_s1_test.sv  
../uvm_components/testcase/m1m2_rd_same_s1_test.sv  
../uvm_components/testcase/m1m2_wr_same_s2_test.sv  
../uvm_components/testcase/m1m2_rd_same_s2_test.sv
../uvm_components/testcase/m1_rd_s1_wr_s2.sv
../uvm_components/testcase/m1_wr_s1_rd_s2.sv
../uvm_components/testcase/full_random.sv
../uvm_components/testcase/equal_corner.sv  




//SVA

 
            


            