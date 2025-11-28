module ALU #(parameter Width = 8)(input clk, input rst, input [Width-1:0] A, input [Width-1:0] B, input[2:0] opcode,output reg [Width-1:0] result, output reg z,output reg c,output reg n, output reg v);
reg [Width:0] temp;
//stage 1 registers
reg [Width-1:0] A_reg,B_reg;
reg [2:0] opcode_reg;
//stage 2 registers
reg [Width-1:0] result_reg;
reg c_temp,v_temp;
//stage 3 registers
reg z_reg,n_reg;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        A_reg <= 0;
        B_reg <= 0;
        opcode_reg <= 0;
        result_reg <= 0;
        c_temp <= 0;
        v_temp <= 0;
        z_reg <= 0;
        n_reg <= 0;
        result <= 0;
        c <= 0;
        v <= 0;
        z <= 0;
        n <= 0;
    end else begin
        //stage 1
        A_reg <=A;
        B_reg <=B;
        opcode_reg <=opcode;
        //stage 2
    case(opcode_reg)
        3'b000: begin
          {c_temp, result_reg} <= A_reg + B_reg;
           v_temp <= ((A_reg[Width-1]) & (B_reg[Width-1]) & ~result_reg[Width-1]) | (~A_reg[Width-1] & ~B_reg[Width-1] & result_reg[Width-1]);
        end
        3'b001: begin
           result_reg <= A_reg - B_reg;
           c_temp <= (A_reg<B_reg);
           v_temp <= (~A_reg[Width-1] & B_reg[Width-1] & result_reg[Width-1]) | (A_reg[Width-1] & ~B_reg[Width-1] & ~result_reg[Width-1]);
        end
        3'b010: result_reg <= A_reg&B_reg;
        3'b011: result_reg <= A_reg|B_reg;
        3'b100: result_reg <= A_reg^B_reg;
        3'b101: result_reg <= ~A_reg;
        3'b110: result_reg <= ~B_reg;
        default: result_reg <= {Width{1'b0}};


    endcase
    //stage 3
        result <= result_reg;
        c <= c_temp;
        v <=v_temp;
        z_reg<= (result_reg == {Width{1'b0}});
        n_reg<= result_reg[Width-1];
        z <= z_reg;
        n <= n_reg;
    end
end
endmodule
