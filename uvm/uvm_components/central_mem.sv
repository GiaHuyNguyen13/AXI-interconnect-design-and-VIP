class centralized_memory_model;

  // Declare a simple memory array (parameterized for flexibility)
  bit [31:0] memory_array [0:1023];  // Example: 1k 32-bit words of memory

  // Constructor to initialize the memory contents
  function new();
    // Initialize the memory with some default values (you can also load it from a file)
    foreach (memory_array[i]) begin
      memory_array[i] = 32'h0 + i;  // Default data, can be changed later
    end
  endfunction

  // Function to write data to memory
  function void write(int address, bit [31:0] data);
    if (address < $size(memory_array)) begin
      memory_array[address] = data;
      // `uvm_info("MEM_WRITE", $sformatf("Wrote %h to address %0d", data, address), UVM_LOW);
    end else begin
      `uvm_error("MEM_WRITE_ERR", $sformatf("Invalid write address: %0d", address));
    end
  endfunction

  // Function to read data from memory
  function bit [31:0] read(int address);
    if (address < $size(memory_array)) begin
      // `uvm_info("MEM_READ", $sformatf("Read %h from address %0d", memory_array[address], address), UVM_LOW);
      return memory_array[address];
    end else begin
      `uvm_error("MEM_READ_ERR", $sformatf("Invalid read address: %0d", address));
      return 32'h0;
    end
  endfunction

endclass
