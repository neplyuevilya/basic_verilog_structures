`timescale 1ns / 1ps

module fifo_tb();

    logic clk;
    logic rst;
    logic write_en;
    logic read_en;
    logic [3:0] data_in;
    logic [3:0] data_out;
    logic full, empty;
    
    //signal connection
    fifo dut (.*);
    
    //clk generate
    initial begin 
        clk = 0;
        forever #10 clk = ~clk;
    end 
    
    //tasks 
    task write_data(input [3:0]data);
        begin 
            @(posedge clk);
            write_en <= 1;
            data_in <= data;
            @(posedge clk);
            write_en <= 0;
        end 
    endtask 
    
    task read_data();
        begin 
            @(posedge clk);
            read_en <= 1;
            @(posedge clk);
            read_en <= 0;
        end 
    endtask
    
    initial begin 
        rst = 1; 
        write_en = 0; 
        read_en = 0; 
        data_in = 0;
        
        #25 rst = 0;
        
        //write and read test 
        write_data(4'b0001);
        read_data();
        
        //overflow FIFO check 
        write_data(4'b0010);
        write_data(4'b0100);
        write_data(4'b1000);
        write_data(4'b1111);
        //this value is ignored and not written to memory
        write_data(4'b1001); 
        
        //read all 
        repeat(5) read_data();
        
        //write again 
        write_data(4'b0001);
        write_data(4'b0011);
        write_data(4'b0111);
        write_data(4'b1000);
    end 
               
endmodule 