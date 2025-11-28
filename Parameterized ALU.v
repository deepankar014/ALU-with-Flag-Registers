module ALU #(parameter Width = 8)(input [Width-1:0] A, input [Width-1:0] B, input[2:0] opcode,output reg [Width-1:0] result, output reg z,output reg c,output reg n, output reg v);
reg [Width:0] temp;
always @(*) begin
temp = {(Width+1){'b0}};
result = (Width)'b0;
c = 0; v = 0; z = 0; n = 0;

    case(opcode)
        3'b000: begin
            temp = A+B;
            result = temp[Width-1:0];
            c = temp[Width];
            v = ((A[Width-1]) & (B[Width-1]) & ~result[Width-1]) | (~A[Width-1] & ~B[Width-1] & result[Width-1]);
        end
        3'b001: begin
            temp = A-B;
            result = temp[Width-1:0];
            c = (A<B);
            v = (~A[Width-1] & B[Width-1] & result[Width-1]) | (A[Width-1] & ~B[Width-1] & ~result[Width-1]);
        end
        3'b010: result = A&B;
        3'b011: result = A|B;
        3'b100: result = A^B;
        3'b101: result = ~A;
        3'b110: result = ~B;
        default :result = 8'b00000000;

    endcase
        z = (result == {Width{1'b0}});
        n = result[Width-1];
end
endmodule
