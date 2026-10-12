module CHARSET(clk, addr, q);
input clk;
input addr;
output q;

wire [11:0] addr;

reg[7:0] q;
reg [7:0] chart[4096];

initial $readmemh("charset.hex", chart);

always @(posedge clk) begin
    q <= chart[addr];
end
endmodule