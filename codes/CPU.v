module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

// Wire
//wire   [6:0]        Op;
wire   [1:0]        ALUOp;
wire                ALUSrc;
wire                RegWrite;
wire   [31:0]       pc_i;
wire   [31:0]       pc_o;
wire   [31:0]       instr;
wire   [31:0]       data;
wire   [31:0]       RS1data;
wire   [31:0]       RS2data;
wire   [31:0]       sign_data;
wire   [31:0]       MUX_data;
wire   [2:0]        ALUCtrl;
wire                Zero;


Control Control(
    .Op_i       (instr[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);



Adder Add_PC(
    .data1_in   (pc_o),
    .data2_in   (32'b100),
    .data_o     (pc_i)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o), 
    .instr_o    (instr)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (instr[19:15]),
    .RS2addr_i   (instr[24:20]),
    .RDaddr_i   (instr[11:7]), 
    .RDdata_i   (data),
    .RegWrite_i (RegWrite), 
    .RS1data_o   (RS1data), 
    .RS2data_o   (RS2data) 
);


MUX32 MUX_ALUSrc(
    .data1_i    (RS2data),
    .data2_i    (sign_data),
    .select_i   (ALUSrc),
    .data_o     (MUX_data)
);



Sign_Extend Sign_Extend(
    .data_i     (instr[31:20]),
    .data_o     (sign_data)
);

  

ALU ALU(
    .data1_i    (RS1data),
    .data2_i    (MUX_data),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (data),
    .Zero_o     (Zero)
);



ALU_Control ALU_Control(
    .funct_i    ({instr[31:25], instr[14:12]}),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);


endmodule

