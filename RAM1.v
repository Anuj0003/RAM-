module RAM_D (clk,rst,wr_en,wr_addr,wr_data,rd_en,rd_addr,rd_data);
//inputs and outputs

parameter DEPTH = 16;
parameter ADDR_WIDTH =  4;
parameter DATA_WIDTH = 8;

input clk,rst;

//write operation
input [ADDR_WIDTH-1:0] wr_addr;
input [DATA_WIDTH-1:0] wr_data;
input wr_en;
//read operation
input [ADDR_WIDTH-1:0] rd_addr;
input rd_en;
output reg [DATA_WIDTH-1:0] rd_data;

	
reg [DATA_WIDTH-1:0] ram [0 : DEPTH - 1];


//reset block
always @(posedge clk)
begin
if(rst)
	rd_data <= 8'b0;
end

//write and read operations
always @(posedge clk)
begin
if (wr_en)
ram[wr_addr] <= wr_data;
end

always @(posedge clk)
begin
if (rd_en)

	rd_data <= ram[rd_addr];

end

	
endmodule

