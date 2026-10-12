module CHARSET (
    input        clk,
    input  [11:0] addr,
    output reg [7:0] q
);

    reg [7:0] chart [0:4095];

    initial $readmemh("charset.hex", chart);

    always @(posedge clk) begin
        q <= chart[addr];
    end
endmodule
