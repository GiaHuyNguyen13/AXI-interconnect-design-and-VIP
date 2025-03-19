class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  `uvm_analysis_imp_decl(_m1)
  `uvm_analysis_imp_decl(_m2)
  `uvm_analysis_imp_decl(_s1)
  `uvm_analysis_imp_decl(_s2)
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  bit [31:0] S1_WIDTH;
  bit m1_slave_num, m2_slave_num; // 0 for slave 1, 1 for slave 2
  master_item m1_queue[$], m2_queue[$];
  slave_item s1_queue[$], s2_queue[$];

  // Queue for checking arbitration
  master_item m1_req_q[$], m2_req_q[$];

  bit [1:0] s1_rd_grant, s1_wr_grant, s2_rd_grant, s2_wr_grant;
  bit [0:0] s1_rd_next_grant, s1_wr_next_grant, s2_rd_next_grant, s2_wr_next_grant;
  bit [1:0] s1_rd_lock, s1_wr_lock, s2_rd_lock, s2_wr_lock; // MSB indicate the master that lock it, LSB the lock status

  uvm_analysis_imp_m1  #(master_item, scoreboard) m1_analysis_imp;
  uvm_analysis_imp_m2  #(master_item, scoreboard) m2_analysis_imp;
  uvm_analysis_imp_s1  #(slave_item, scoreboard)  s1_analysis_imp;
  uvm_analysis_imp_s2  #(slave_item, scoreboard)  s2_analysis_imp;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m1_analysis_imp = new("m1_analysis_imp", this);
    m2_analysis_imp = new("m2_analysis_imp", this);
    s1_analysis_imp = new("s1_analysis_imp", this);
    s2_analysis_imp = new("s2_analysis_imp", this);

    // if (!uvm_config_db#(centralized_memory_model)::get(this, "", "central_memory", mem))
    //   `uvm_fatal("CONFIG_ERR", "Could not get centralized memory from config DB.")
    if (!uvm_config_db#(bit[31:0])::get(this, "", "S1_WIDTH", S1_WIDTH))
      `uvm_fatal("CONFIG_ERR", "Could not get S1_WIDTH from config DB.")
  endfunction

  virtual function void write_m1(master_item m1_item);
      if (m1_item.axi_rvalid && m1_item.axi_rready) begin
        m1_req_q.push_back(m1_item);
        grant_req(0, slavedecode(m1_item.axi_araddr));
        m1_queue.push_back(m1_item);
      end
      if (m1_item.axi_wvalid && m1_item.axi_wready) begin
        m1_req_q.push_back(m1_item);
        grant_req(0, slavedecode(m1_item.axi_awaddr));
        m1_queue.push_back(m1_item);
      end
      
  endfunction : write_m1


  virtual function write_m2 (master_item m2_item);
      if (m2_item.axi_rvalid && m2_item.axi_rready) begin
        m2_req_q.push_back(m2_item);
        grant_req(0, slavedecode(m2_item.axi_araddr));
        m2_queue.push_back(m2_item);       
      end
      if (m2_item.axi_wvalid && m2_item.axi_wready) begin
        m2_req_q.push_back(m2_item);
        grant_req(0, slavedecode(m2_item.axi_awaddr));
        m2_queue.push_back(m2_item);        
      end

  endfunction : write_m2 


  virtual function write_s1 (slave_item s1_item);
      if (s1_item.axi_rvalid && s1_item.axi_rready) begin
        s1_queue.push_back(s1_item);
        if(s1_rd_grant == 2'b01) compare(0, 0, 0);
        if(s1_rd_grant == 2'b10) compare(1, 0, 0);      
      end
      if (s1_item.axi_wvalid && s1_item.axi_wready) begin
        s1_queue.push_back(s1_item);
        if(s1_wr_grant == 2'b01) compare(0, 0, 1);
        if(s1_wr_grant == 2'b10) compare(1, 0, 1);      
      end
  endfunction : write_s1 


  virtual function write_s2 (slave_item s2_item);
      if (s2_item.axi_rvalid && s2_item.axi_rready) begin
        s2_queue.push_back(s2_item);
        if(s2_rd_grant == 2'b01) compare(0, 0, 0);
        if(s2_rd_grant == 2'b10) compare(1, 0, 0);      
      end
      if (s2_item.axi_wvalid && s2_item.axi_wready) begin
        s2_queue.push_back(s2_item);
        if(s2_wr_grant == 2'b01) compare(0, 0, 1);
        if(s2_wr_grant == 2'b10) compare(1, 0, 1);      
      end

  endfunction : write_s2


virtual function void grant_req(input bit op, input int slv_num); // Change grant of each slave, arbiter simulator
    if(s1_rd_lock == 2'b01 && m1_req_q[0].axi_rlast) s1_rd_lock = 2'b00;
    if(s1_rd_lock == 2'b11 && m2_req_q[0].axi_rlast) s1_rd_lock = 2'b00;
    if(s2_rd_lock == 2'b01 && m1_req_q[0].axi_rlast) s2_rd_lock = 2'b00;
    if(s2_rd_lock == 2'b11 && m2_req_q[0].axi_rlast) s2_rd_lock = 2'b00;

    if(s1_wr_lock == 2'b01 && m1_req_q[0].axi_rlast) s1_wr_lock = 2'b00;
    if(s1_wr_lock == 2'b11 && m2_req_q[0].axi_rlast) s1_wr_lock = 2'b00;
    if(s2_wr_lock == 2'b01 && m1_req_q[0].axi_rlast) s2_wr_lock = 2'b00;
    if(s2_wr_lock == 2'b11 && m2_req_q[0].axi_rlast) s2_wr_lock = 2'b00;

    case (op)
      1'b0: begin
        if(!m1_req_q.size() && !m2_req_q.size() && s1_rd_lock[0] == 0 && s2_rd_lock[0] == 0) begin
          s1_rd_grant = 2'b00; s2_rd_grant = 2'b00;
        end
        if (m1_req_q.size() && !m2_req_q.size() && slv_num == 0 && s1_rd_lock[0] == 0) begin
           s1_rd_grant = 2'b01; s2_rd_grant = 2'b00; s1_rd_next_grant = 1'b1; s1_rd_lock = 2'b01;
        end 
        if (m1_req_q.size() && !m2_req_q.size() && slv_num == 1 && s2_rd_lock[0] == 0) begin
           s1_rd_grant = 2'b00; s2_rd_grant = 2'b01; s2_rd_next_grant = 1'b1; s2_rd_lock = 2'b01;
        end
        if (!m1_req_q.size() && m2_req_q.size() && slv_num == 0 && s1_rd_lock[0] == 0) begin
           s1_rd_grant = 2'b10; s2_rd_grant = 2'b00; s1_rd_next_grant = 1'b0; s1_rd_lock = 2'b11;
        end 
        if (!m1_req_q.size() && m2_req_q.size() && slv_num == 1 && s2_rd_lock[0] == 0) begin
           s1_rd_grant = 2'b00; s2_rd_grant = 2'b10; s2_rd_next_grant = 1'b0; s2_rd_lock = 2'b11;
        end
        if (m1_req_q.size() && m2_req_q.size() && slv_num == 0  && s1_rd_lock[0] == 0) begin
            if(s1_rd_next_grant == 1'b0) begin
              s1_rd_grant = 2'b01; s2_rd_grant = 2'b00; s1_rd_next_grant = 1'b1; s1_rd_lock = 2'b01;
            end else begin
              s1_rd_grant = 2'b10; s2_rd_grant = 2'b00; s1_rd_next_grant = 1'b0; s1_rd_lock = 2'b11;
            end
        end
        if (m1_req_q.size() && m2_req_q.size() && slv_num == 1 && s2_rd_lock[0] == 0) begin
            if(s2_rd_next_grant == 1'b0) begin
              s1_rd_grant = 2'b00; s2_rd_grant = 2'b01; s2_rd_next_grant = 1'b1; s2_rd_lock = 2'b01;
            end else begin
              s1_rd_grant = 2'b00; s2_rd_grant = 2'b10; s2_rd_next_grant = 1'b0; s2_rd_lock = 2'b11;
            end
        end   
      end

      1'b1: begin
        if(!m1_req_q.size() && !m2_req_q.size() && s1_wr_lock[0] == 0 && s2_wr_lock[0] == 0) begin
          s1_wr_grant = 2'b00; s2_wr_grant = 2'b00;
        end
        if (m1_req_q.size() && !m2_req_q.size() && slv_num == 0 && s1_wr_lock[0] == 0) begin
           s1_wr_grant = 2'b01; s2_wr_grant = 2'b00; s1_wr_next_grant = 1'b1; s1_wr_lock = 2'b01;
        end 
        if (m1_req_q.size() && !m2_req_q.size() && slv_num == 1 && s2_wr_lock[0] == 0) begin
           s1_wr_grant = 2'b00; s2_wr_grant = 2'b01; s2_wr_next_grant = 1'b1; s2_wr_lock = 2'b01;
        end
        if (!m1_req_q.size() && m2_req_q.size() && slv_num == 0 && s1_wr_lock[0] == 0) begin
           s1_wr_grant = 2'b10; s2_wr_grant = 2'b00; s1_wr_next_grant = 1'b0; s1_wr_lock = 2'b11;
        end 
        if (!m1_req_q.size() && m2_req_q.size() && slv_num == 1 && s2_wr_lock[0] == 0) begin
           s1_wr_grant = 2'b00; s2_wr_grant = 2'b10; s2_wr_next_grant = 1'b0; s2_wr_lock = 2'b11;
        end
        if (m1_req_q.size() && m2_req_q.size() && slv_num == 0  && s1_wr_lock[0] == 0) begin
            if(s1_wr_next_grant == 1'b0) begin
              s1_wr_grant = 2'b01; s2_wr_grant = 2'b00; s1_wr_next_grant = 1'b1; s1_wr_lock = 2'b01;
            end else begin
              s1_wr_grant = 2'b10; s2_wr_grant = 2'b00; s1_wr_next_grant = 1'b0; s1_wr_lock = 2'b11;
            end
        end
        if (m1_req_q.size() && m2_req_q.size() && slv_num == 1 && s2_wr_lock[0] == 0) begin
            if(s2_wr_next_grant == 1'b0) begin
              s1_wr_grant = 2'b00; s2_wr_grant = 2'b01; s2_wr_next_grant = 1'b1; s2_wr_lock = 2'b01;
            end else begin
              s1_wr_grant = 2'b00; s2_wr_grant = 2'b10; s2_wr_next_grant = 1'b0; s2_wr_lock = 2'b11;
            end
        end
      end
    endcase

    m1_req_q.delete();
    m2_req_q.delete();
endfunction : grant_req


virtual function void compare(input int master, input int slave, input bit op); // 0 for read, 1 for write
    master_item temp_mas;
    slave_item temp_slv;
    case (master)
        0: begin
            if (slave == 0) begin 
                temp_mas = m1_queue.pop_front();
                temp_slv = s1_queue.pop_front();
                if (!compare_mas_slv(temp_mas, temp_slv)) begin
                    if (op == 0) begin
                        if (!(temp_mas.axi_rdata % 2) && !(temp_mas.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 1 and Slave 1 match"), UVM_LOW); end
                        else begin `uvm_error("SCBD", $sformatf("Master 1 READ from the wrong slave (Correct: Slave 1)")); end
                    end else begin
                        if (!(temp_slv.axi_rdata % 2) && !(temp_slv.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 1 and Slave 1 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 1 WRITE to the wrong slave (Correct: Slave 1)")); end
                    end
                end else begin
                    `uvm_error("SCBD", $sformatf("Master 1 and Slave 1 mismatch ERROR code: %0d", compare_mas_slv(temp_mas, temp_slv))); end
            end
            else if (slave == 1) begin
                temp_mas = m1_queue.pop_front();
                temp_slv = s2_queue.pop_front();
                if (!compare_mas_slv(temp_mas, temp_slv)) begin
                    if (op == 0) begin
                        if ((temp_mas.axi_rdata % 2) || (temp_mas.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 1 and Slave 2 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 1 READ from the wrong slave (Correct: Slave 2)")); end
                    end else begin
                        if (!(temp_slv.axi_rdata % 2) && !(temp_slv.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 1 and Slave 2 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 1 WRITE to the wrong slave (Correct: Slave 2)")); end
                    end
                end else begin
                    `uvm_error("SCBD", $sformatf("Master 1 and Slave 2 mismatch ERROR code: %0d", compare_mas_slv(temp_mas, temp_slv))); end
            end
        end
        1: begin
            if (slave == 0) begin
                temp_mas = m2_queue.pop_front();
                temp_slv = s1_queue.pop_front();
                if (!compare_mas_slv(temp_mas, temp_slv)) begin
                    if (op == 0) begin
                        if (!(temp_mas.axi_rdata % 2) && !(temp_mas.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 2 and Slave 1 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 2 READ from the wrong slave (Correct: Slave 1)")); end
                    end else begin
                        if ((temp_slv.axi_rdata % 2) || (temp_slv.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 2 and Slave 1 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 2 WRITE to the wrong slave (Correct: Slave 1)")); end
                    end
                end else begin
                    `uvm_error("SCBD", $sformatf("Master 2 and Slave 1 mismatch ERROR code: %0d", compare_mas_slv(temp_mas, temp_slv))); end
            end
            else if (slave == 1) begin
                temp_mas = m2_queue.pop_front();
                temp_slv = s2_queue.pop_front();
                if (!compare_mas_slv(temp_mas, temp_slv)) begin
                    if (op == 0) begin
                        if ((temp_mas.axi_rdata % 2) || (temp_mas.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 2 and Slave 2 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 2 READ from the wrong slave (Correct: Slave 2)")); end
                    end else begin
                        if ((temp_slv.axi_rdata % 2) || (temp_slv.axi_wdata % 2)) begin
                            `uvm_info("SCBD", $sformatf("Master 2 and Slave 2 match"), UVM_LOW); end
                        else begin
                            `uvm_error("SCBD", $sformatf("Master 2 WRITE to the wrong slave (Correct: Slave 2)")); end
                    end
                end else begin
                    `uvm_error("SCBD", $sformatf("Master 2 and Slave 2 mismatch ERROR code: %0d", compare_mas_slv(temp_mas, temp_slv))); end
            end
        end
        default: begin
            `uvm_info("SCBD", "Invalid master/slave combination", UVM_LOW);
        end
    endcase
endfunction : compare



  virtual function int compare_mas_slv(input master_item mas, input slave_item slv);
    if (mas.axi_awid != slv.axi_awid) return 1;
    else if (mas.axi_awaddr != slv.axi_awaddr) return 2;
    else if (mas.axi_awlen != slv.axi_awlen) return 3;
    else if (mas.axi_awsize != slv.axi_awsize) return 4;
    else if (mas.axi_awburst != slv.axi_awburst) return 5;
    else if (mas.axi_awlock != slv.axi_awlock) return 6;
    else if (mas.axi_awcache != slv.axi_awcache) return 7;
    else if (mas.axi_awprot != slv.axi_awprot) return 8;
    else if (mas.axi_awvalid != slv.axi_awvalid) return 9;
    else if (mas.axi_awready != slv.axi_awready) return 10;

    else if (mas.axi_wdata != slv.axi_wdata) return 11;
    else if (mas.axi_wstrb != slv.axi_wstrb) return 12;
    else if (mas.axi_wlast != slv.axi_wlast) return 13;
    else if (mas.axi_wvalid != slv.axi_wvalid) return 14;
    else if (mas.axi_wready != slv.axi_wready) return 15;

    else if (mas.axi_bid != slv.axi_bid) return 16;
    else if (mas.axi_bresp != slv.axi_bresp) return 17;
    else if (mas.axi_bvalid != slv.axi_bvalid) return 18;
    else if (mas.axi_bready != slv.axi_bready) return 19;

    else if (mas.axi_arid != slv.axi_arid) return 20;
    else if (mas.axi_araddr != slv.axi_araddr) return 21;
    else if (mas.axi_arlen != slv.axi_arlen) return 22;
    else if (mas.axi_arsize != slv.axi_arsize) return 23;
    else if (mas.axi_arburst != slv.axi_arburst) return 24;
    else if (mas.axi_arlock != slv.axi_arlock) return 25;
    else if (mas.axi_arcache != slv.axi_arcache) return 26;
    else if (mas.axi_arprot != slv.axi_arprot) return 27;
    else if (mas.axi_arvalid != slv.axi_arvalid) return 28;
    else if (mas.axi_arready != slv.axi_arready) return 29;

    else if (mas.axi_rid != slv.axi_rid) return 30;
    else if (mas.axi_rdata != slv.axi_rdata) return 31;
    else if (mas.axi_rresp != slv.axi_rresp) return 32;
    else if (mas.axi_rlast != slv.axi_rlast) return 33;
    else if (mas.axi_rvalid != slv.axi_rvalid) return 34;
    else if (mas.axi_rready != slv.axi_rready) return 35;

    return 0; // All checks passed, return 0
  endfunction : compare_mas_slv

  virtual function int slavedecode(input bit [31:0] addr);
    if (addr < S1_WIDTH) return 0;
    else return 1;
  endfunction : slavedecode  

  
endclass
