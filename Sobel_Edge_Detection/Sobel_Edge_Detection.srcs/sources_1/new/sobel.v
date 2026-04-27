module sobel(
    input clk,
    input rst,
    input [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,
    input valid_in,
    output reg [7:0] pixel_out,
    output reg valid_out
);

reg signed [10:0] gx, gy;
reg [11:0] mag;

always @(posedge clk) begin
    if (rst) begin
        pixel_out <= 0;
        valid_out <= 0;
    end
    else if (valid_in) begin
        gx = (p6 + 2*p7 + p8) - (p0 + 2*p1 + p2);
        gy = (p0 + 2*p3 + p6) - (p2 + 2*p5 + p8);

        mag = (gx[10] ? -gx : gx) + (gy[10] ? -gy : gy);

        pixel_out <= (mag > 255) ? 8'hFF : mag[7:0];
        valid_out <= 1;
    end
    else valid_out <= 0;
end

endmodule