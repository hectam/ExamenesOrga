//! module:DIG_ROM_256X32_InstMem
module AsyncROM (
  input [7:0] addr,
  input en,
  output [31:0] read_data
);
  reg [31:0] memory[0:255] /*verilator public*/;

  assign read_data = en? memory[addr] : 32'hz;
  
  initial begin
`ifndef NO_INIT_MEM
    $readmemh("code.mif", memory, 0, 255);
`endif
  end
endmodule 

//! module:DIG_RAMDualPort
module RAMDualPort (
  input [7:0] addr,
  input [31:0] write_data,
  input mem_write,
  input clk,
  input mem_read,
  output [31:0] read_data
);
  reg [31:0] memory[0:255] /*verilator public*/;

  assign read_data = mem_read? memory[addr] : 32'hz;

  always @ (posedge clk) begin
    if (mem_write)
      memory[addr] <= write_data;
  end

  initial begin
`ifndef NO_INIT_MEM
    $readmemh("data.mif", memory, 0, 255);
`endif
  end
endmodule

//! module:DIG_RegisterFile
module RegisterFile (
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    input write_en,
    input clk,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    reg [31:0] memory[0:31] /*verilator public*/;
    
    assign read_data1 = memory[read_addr1];
    assign read_data2 = memory[read_addr2];
    
    always @(posedge clk)
    begin
        if (write_en)
            memory[write_addr] <= write_data;
    end

    initial begin
        memory[0] = 32'd0;
    end
endmodule

//! PC:begin
  reg [31:0] PC /*verilator public*/;

  assign $Q = PC;

  always @ (posedge $C) begin
    if ($en)
      PC <= $D;
  end
//! PC:end

//! DIG_ROM_256X32_InstMem:begin
  AsyncROM inst_mem (
    .addr( $A ),
    .en( $sel ),
    .read_data( $D )
  );
//! DIG_ROM_256X32_InstMem:end

//! DIG_RAMDualPort:begin
  RAMDualPort data_mem(
    .addr( $A ),
    .mem_write( $str ),
    .write_data( $Din ),
    .clk( $C ),
    .mem_read( $ld ),
    .read_data( $D )
  );
//! DIG_RAMDualPort:end

//! DIG_RegisterFile:begin
  RegisterFile reg_file (
    .clk( $C ),
    .read_addr1( $Ra ),
    .read_addr2( $Rb ),
    .write_addr( $Rw ),
    .write_en( $we ),
    .write_data( $Din ),
    .read_data1( $Da ),
    .read_data2( $Db )
  );
//! DIG_RegisterFile:end
