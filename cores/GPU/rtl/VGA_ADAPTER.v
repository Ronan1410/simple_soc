module VGA_ADAPTER(
    input clk,
    output vga_h_sync, 
    output vga_v_sync,

    input RD, 
    input GD,
    input BD,

    output [9:0] x,
    output [8:0] y,

    output R,
    output G,
    output B
);

reg [9:0] CounterX;
reg [8:0] CounterY;

reg vga_HS, vga_VS;

wire CounterXmaxed = (CounterX == 799);
wire CountetYmaxed = (CounterY == 524);

assign x = CounterX;
assign y = CounterY;

assign vga_h_sync = ~vga_HS;
assign vga_v_sync = ~vga_VS;

assign R = RD;
assign G = GD;
assign B = BD;

always @(posedge clk) begin
    if(CounterXmaxed)
        CounterX <= 0;
    else
        CounterX <= CounterX + 1;
end

always @(posedge clk) begin
    if(CounterXmaxed)
        if(CountetYmaxed)
            CounterY <= 0;
        else
            CounterY <= CounterY + 1;
end

always @(posedge clk) begin
    vga_HS <= (CounterX[9:3] == 0);
	vga_VS <= (CounterY == 0);
end

endmodule