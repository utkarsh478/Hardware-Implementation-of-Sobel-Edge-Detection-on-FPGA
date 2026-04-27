module vga_controller(
    input clk,
    input rst,
    output reg hsync,
    output reg vsync,
    output reg video_on,
    output reg [9:0] x,
    output reg [9:0] y,
    output p_tick
);

parameter H_DISPLAY=640, H_FRONT=16, H_SYNC=96, H_BACK=48, H_TOTAL=800;
parameter V_DISPLAY=480, V_FRONT=10, V_SYNC=2, V_BACK=33, V_TOTAL=525;

reg [1:0] div;
assign p_tick = (div == 0);

always @(posedge clk) begin
    if (rst) div <= 0;
    else div <= div + 1;
end

always @(posedge clk) begin
    if (rst) begin x<=0; y<=0; end
    else if (p_tick) begin
        if (x == H_TOTAL-1) begin
            x <= 0;
            if (y == V_TOTAL-1) y <= 0;
            else y <= y + 1;
        end else x <= x + 1;
    end
end

always @(posedge clk) begin
    hsync <= ~((x >= H_DISPLAY+H_FRONT) && (x < H_DISPLAY+H_FRONT+H_SYNC));
    vsync <= ~((y >= V_DISPLAY+V_FRONT) && (y < V_DISPLAY+V_FRONT+V_SYNC));
    video_on <= (x < H_DISPLAY) && (y < V_DISPLAY);
end

endmodule