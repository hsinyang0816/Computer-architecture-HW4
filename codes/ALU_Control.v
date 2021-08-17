module ALU_Control
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

// Ports
input   [9:0]      funct_i;
input   [1:0]      ALUOp_i;
output  [2:0]      ALUCtrl_o;

reg     [2:0]      ALUCtrl_o;

always@(funct_i)
begin
    if (funct_i[9:0] == 10'b0000000111)
        ALUCtrl_o = 3'b000;
    else if (funct_i == 10'b0000000100) 
        ALUCtrl_o = 3'b001;
    else if (funct_i == 10'b0000000001) 
        ALUCtrl_o = 3'b010;
    else if (funct_i == 10'b0000000000 && ALUOp_i == 2'b10) 
        ALUCtrl_o = 3'b011;
    else if (funct_i == 10'b0100000000 && ALUOp_i == 2'b10) 
        ALUCtrl_o = 3'b100;
    else if (funct_i == 10'b0000001000 && ALUOp_i == 2'b10) 
        ALUCtrl_o = 3'b101;
    else if (funct_i[2:0] == 3'b000 && ALUOp_i == 2'b00) 
        ALUCtrl_o = 3'b110;
    else 
        ALUCtrl_o = 3'b111;
end

endmodule
