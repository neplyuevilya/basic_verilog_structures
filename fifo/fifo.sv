module fifo
#(
    parameter mem_width = 3,
    parameter mem_depth = 3
)
(
    input logic clk,
    input logic rst,
    input logic write_en,
    input logic read_en,
    input logic [3:0] data_in,
    output logic [3:0] data_out,
    output logic full,
    output logic empty
    );

logic [1:0] wr_ptr;
logic [1:0] rd_ptr;
logic [mem_width:0] mem [mem_depth:0];

initial begin 
for (int i = 0; i <= mem_depth; i++) begin 
    mem[i] = '0;
end
end 

logic [2:0] counter;
assign full = (counter == 4);
assign empty = (counter == 0);

always_ff @(posedge clk or posedge rst) begin 
    if (rst) begin 
        data_out <= '0;
        wr_ptr <= '0;
        rd_ptr <= '0;
        counter <= '0;
    end
    else begin 
        if (write_en && !full) begin 
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end 
    
        if (read_en && !empty) begin 
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end  
        
        if (write_en && !read_en && !full) begin 
            counter <= counter + 1; 
        end
        else 
        if (!write_en && read_en && !empty) begin 
            counter <= counter - 1;
        end 
    end
end 

endmodule
