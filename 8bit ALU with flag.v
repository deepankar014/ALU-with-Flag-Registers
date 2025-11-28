module ALU(input [7:0] A, input [7:0] B, input[2:0] opcode,output reg [7:0] result, output reg z,output reg c,output reg n, output reg v);
reg [8:0] temp;
always @(*) begin
temp = 9'b0;
result = 8'b0;
c = 0; v = 0; z = 0; n = 0;

    case(opcode)
        3'b000: begin
            temp = A+B;
            result = temp[7:0];
            c = temp[8];
            v = ((A[7]) & (B[7]) & ~result[7]) | (~A[7] & ~B[7] & result[7]);
        end
        3'b001: begin
            temp = A-B;
            result = temp[7:0];
            c = (A<B);
            v = (~A[7] & B[7] & result[7]) | (A[7] & ~B[7] & ~result[7]);
        end
        3'b010: result = A&B;
        3'b011: result = A|B;
        3'b100: result = A^B;
        3'b101: result = ~A;
        3'b110: result = ~B;
        default :result = 8'b00000000;

    endcase
        z = (result == 8'b00000000);
        n = result[7];
end
endmodule
