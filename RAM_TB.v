
module ram_tb();
parameter ADDR_WIDTH = 4;
parameter DEPTH = 16;
parameter DATA_WIDTH = 8;
reg clk,rst;
reg wr_en;
reg [ADDR_WIDTH-1:0] wr_addr;
reg [DATA_WIDTH-1:0] wr_data;
//read
reg rd_en;
reg [ADDR_WIDTH-1:0] rd_addr;
wire [DATA_WIDTH-1:0] rd_data;
//reg [DATA_WIDTH-1:0] RAM [0:DEPTH-1];
//instantiation
RAM_D DUT (.clk(clk),.rst(rst),.wr_en(wr_en),.wr_addr(wr_addr),.wr_data(wr_data),.rd_en(rd_en),.rd_addr(rd_addr),.rd_data(rd_data));

//clock generation
initial
clk = 1'b0;
always #10 clk = ~clk;

//reset task
task reset();
 begin
 @(negedge clk);
 rst=1'b1;
 @(negedge clk);
 rst=1'b0;
 end
 endtask
//write task

task write(input [7:0] data_write,input [3:0] data_read1);
 begin
 @(negedge clk);
 wr_en = 1'b1;
 wr_data = data_write;
 wr_addr = data_read1;
 end
endtask

 //task read
task read(input [ADDR_WIDTH-1:0] data_read);
 begin
 @(negedge clk);
 rd_en=1'b1;
 rd_addr=data_read;
 end
endtask
 
//stimulus
initial 
begin
reset();

repeat(3)
read($random);
@(negedge clk); rd_en=0;

repeat(10)
write(8'b10101010,4'b1111);
@(negedge clk);wr_en=0;

repeat(10)
read(4'b1111);
@(negedge clk);rd_en=0;

repeat(10)
write(8'b10101111,4'b1100);
@(negedge clk);
wr_en=0;

/*repeat(5)@(negedge clk);
wr_en = 0;
repeat(2)@(negedge clk);
read($random);
repeat(5)@(negedge clk);`
write($random);

repeat(5)@(negedge clk);*/
repeat(5)@(negedge clk);
$finish;
end

endmodule	 
 