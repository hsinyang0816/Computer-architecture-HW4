module Control
(
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input   [6:0]       Op_i;
output  [1:0]       ALUOp_o;
output              ALUSrc_o;
output              RegWrite_o;

reg     [1:0]       ALUOp_o;
reg                 ALUSrc_o;
reg                 RegWrite_o;


always@(Op_i)
begin
    assign RegWrite_o = 1'b1;
    assign ALUSrc_o = Op_i[5] ? 1'b0 : 1'b1;
    assign ALUOp_o = Op_i[5] ? 2'b10 : 2'b00;
end 

endmodule
