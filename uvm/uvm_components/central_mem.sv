class centralized_memory_model;

  // Declare a simple memory array (parameterized for flexibility)
  bit [31:0] memory_array [0:1023];
  int kind;
  int val; // Counter for numbers

  // Constructor to initialize the memory contents
  // Slave 1 is even, slave 2 is odd
  function new(input int type_in); // 0 for even, 1 for odd
    this.kind = type_in; // Assign constructor argument to class member

    if (this.kind == 1) begin // Odd numbers
      val = 1;
      for (int i = 0; i < $size(memory_array); i++) begin
        memory_array[i] = val;
        val += 2; // Move to the next odd number
      end
    end else if (this.kind == 0) begin // Even numbers
      val = 0;
      for (int i = 0; i < $size(memory_array); i++) begin
        memory_array[i] = val;
        val += 2; // Move to the next even number
      end
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
