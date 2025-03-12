
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
../uvm_components/mas1_interface.sv
../uvm_components/mas1_interface.sv
../uvm_components/slv1_interface.sv
../uvm_components/slv2_interface.sv

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

// AXIL Agent
../../src/axil_agent/axil_item.sv
../../src/axil_agent/axil_gen_item_seq.sv
../../src/axil_agent/axil_monitor.sv
../../src/axil_agent/axil_driver.sv
../../src/axil_agent/axil_agent.sv

//Reference models
../../src/rd_ref_model.sv
../../src/wr_ref_model.sv

// Remaining UVM components
../../src/scoreboard.sv
../../src/env.sv
../../src/base_test.sv
../../src/burst_test.sv

//SVA
../../src/SVA.sv
 
            


            