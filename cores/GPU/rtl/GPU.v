module GPU_core(
    input btn1,
    input btn2,
    input clk,

    input wire [31:0] W_ADDR,
    input wire [31:0] W_DAT_I,
    input wire W_CLK,
    input wire W_RST,

    output reg [31:0] W_DAT_O,
    output reg W_ACK,

    input LED_CLK,
    output reg RESET,
    output reg DATA
);

reg [3:0] cbyte;
reg [15:0] cc_code;
reg [15:0] ccolor;
wire [15:0] char_code;
reg [8:0] x;
reg [8:0] y;

reg ss;

wire [7:0] sline;

V_RAM vram(clk, 16'b0, cc_code, {4'd240 - y[7:4], x[8:3]}, 16'h0, 1'b0, 1'b0, char_code);

CHARSET charset(clk, {char_code[7:0], 4'd240 - y[3:0]}, sline);

always@(posedge clk) begin
    if(W_RST) begin
        RESET <= 1'b1;
        cbyte <= 4'b1111;
        x <= 0;
        y <= 0;
    end
    else begin
        RESET <= 1'b0;
        {ss, cbyte} <= cbyte + 1;

        if(ss) begin
            y <= y + 1;
            if(y >= 239) begin
                y <= 0;
                x <= x + 1;
                if(x >= 319) begin
                    x <= 0;
                end
            end
            ccolor <= sline[3'b111 - x[2:0] - 1] ? 16'h0000 : 16'hFFFF;
        end
        DATA <= ccolor[cbyte];
    end
end
endmodule