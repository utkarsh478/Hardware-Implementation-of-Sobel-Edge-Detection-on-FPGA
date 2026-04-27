module line_buffer(
    input clk,
    input rst,
    input [7:0] pixel_in,
    input pixel_valid,
    output reg [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,
    output reg valid_out
);

parameter WIDTH = 256;

reg [7:0] line0 [0:WIDTH-1];
reg [7:0] line1 [0:WIDTH-1];
reg [7:0] line2 [0:WIDTH-1];

reg [7:0] col;
reg [1:0] row_count;
reg filled;

always @(posedge clk) begin
    if (rst) begin
        col <= 0;
        row_count <= 0;
        filled <= 0;
        valid_out <= 0;
    end
    else if (pixel_valid) begin

        line2[col] <= line1[col];
        line1[col] <= line0[col];
        line0[col] <= pixel_in;

        if (col == WIDTH-1) begin
            col <= 0;
            if (row_count < 2)
                row_count <= row_count + 1;
            else
                filled <= 1;
        end else col <= col + 1;

        if (filled && col > 0 && col < WIDTH-1) begin
            p0 <= line2[col-1]; p1 <= line2[col]; p2 <= line2[col+1];
            p3 <= line1[col-1]; p4 <= line1[col]; p5 <= line1[col+1];
            p6 <= line0[col-1]; p7 <= line0[col]; p8 <= line0[col+1];
            valid_out <= 1;
        end else valid_out <= 0;
    end
    else valid_out <= 0;
end

endmodule