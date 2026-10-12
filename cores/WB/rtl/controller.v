module WB_CONTROLLER(
    input clk,
    input rst,

    output wire W_CLK,
    oupput wire W_RST
);

reg [3:0] t;

assign W_CLK = t[3];
assign W_RST = rst;

always @(posedge clk) begin
    t = t + 1;
end

endmodule