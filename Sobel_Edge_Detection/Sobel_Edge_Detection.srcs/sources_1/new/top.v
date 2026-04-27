module top(
    input clk,
    input rst,
    output hsync,
    output vsync,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b
);

parameter IMG_W = 256;
parameter IMG_H = 256;
parameter X_OFFSET = 192;
parameter Y_OFFSET = 112;

wire [9:0] x,y;
wire video_on;
wire p_tick;

// VGA
vga_controller vga(
    .clk(clk),
    .rst(rst),
    .hsync(hsync),
    .vsync(vsync),
    .video_on(video_on),
    .x(x),
    .y(y),
    .p_tick(p_tick)
);

// Image area
wire img_area;
assign img_area = (x >= X_OFFSET && x < X_OFFSET + IMG_W &&
                   y >= Y_OFFSET && y < Y_OFFSET + IMG_H);

// Address
wire [15:0] addr;
assign addr = img_area ? ((y - Y_OFFSET)*IMG_W + (x - X_OFFSET)) : 0;

// BRAM
wire [7:0] pixel;
blk_mem_gen_0 bram(
    .clka(clk),
    .addra(addr),
    .douta(pixel)
);

// ⭐ BRAM latency fix
reg [7:0] pixel_reg;
always @(posedge clk) begin
    if (p_tick)
        pixel_reg <= pixel;
end

// Pixel valid (SYNCED)
wire pixel_valid;
assign pixel_valid = img_area && p_tick;

// Line buffer
wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8;
wire lb_valid;

line_buffer lb(
    .clk(clk),
    .rst(rst),
    .pixel_in(pixel_reg),
    .pixel_valid(pixel_valid),
    .p0(p0),.p1(p1),.p2(p2),
    .p3(p3),.p4(p4),.p5(p5),
    .p6(p6),.p7(p7),.p8(p8),
    .valid_out(lb_valid)
);

// Sobel
wire [7:0] sobel_out;
wire sobel_valid;

sobel sob(
    .clk(clk),
    .rst(rst),
    .p0(p0),.p1(p1),.p2(p2),
    .p3(p3),.p4(p4),.p5(p5),
    .p6(p6),.p7(p7),.p8(p8),
    .valid_in(lb_valid),
    .pixel_out(sobel_out),
    .valid_out(sobel_valid)
);

// VGA output
reg [3:0] r,g,b;

always @(posedge clk) begin
    if (video_on && img_area) begin
        r <= sobel_out[7:4];
        g <= sobel_out[7:4];
        b <= sobel_out[7:4];
    end else begin
        r <= 0;
        g <= 0;
        b <= 0;
    end
end

assign vga_r = r;
assign vga_g = g;
assign vga_b = b;

endmodule