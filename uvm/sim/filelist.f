
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
../uvm_components/tb.sv

// Central memory
../uvm_components/central_mem.sv

// Master Agent
../uvm_components/master_agent/master_item.sv
../uvm_components/master_agent/master_gen_item_seq.sv
../uvm_components/master_agent/master_monitor.sv
../uvm_components/master_agent/master_driver.sv
../uvm_components/master_agent/master_agent.sv

// Slave Agent
../uvm_components/slave_agent/slave_item.sv
../uvm_components/slave_agent/slave_gen_item_seq.sv
../uvm_components/slave_agent/slave_monitor.sv
../uvm_components/slave_agent/slave_rd_driver.sv
../uvm_components/slave_agent/slave_wr_driver.sv
../uvm_components/slave_agent/slave_agent.sv

//Reference models
//../uvm_components/rd_ref_model.sv
//../uvm_components/wr_ref_model.sv

// Remaining UVM components
../uvm_components/scoreboard.sv
../uvm_components/env.sv
../uvm_components/base_test.sv

//SVA

 
            


            