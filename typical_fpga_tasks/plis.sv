//Опишите на Verilog HDL мультиплексор 2 в 1 при помощи непрерывного 
//присваивания. 

module plis(
    input a, b, sel,
    output out
    );

assign out = (a & ~sel) | (b & sel);    

endmodule


//Опишите на Verilog HDL сдвиговый регистр на 4 разряда при помощи 
//неблокирующего присваивания

module plis(
    input logic d,
    input logic clk,
    input logic rst,
    output logic [3:0] q
);

always_ff @(posedge clk) begin 
    if (rst) begin 
        q[3:0] <= 4'b0000;
    end
    else begin 
        q[0] <= d;
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
    end
end

endmodule

//Опишите на Verilog HDL сдвиговый регистр на 5 разрядов при помощи 
//блокирующего присваивания. 

module plis(
    input logic d,
    input logic clk,
    input logic rst,
    output logic [4:0] q
);

always_ff @(posedge clk) begin
    if (rst) begin 
    q = 5'b00000;
    end
    else begin
    q[4] = q[3];
    q[3] = q[2];
    q[2] = q[1];
    q[1] = q[0];
    q[0] = d; 
    end
end

endmodule

//Опишите на Verilog HDL 8-разрядный реверсивный счётчик с асинхронным 
//сбросом и синхронной параллельной загрузкой при помощи процедурного 
//присваивания 

module plis(
    input logic [7:0] d,
    input logic clk,
    input logic rst,
    input logic load, //разрешает загрузку данных 
    input logic direction, //вверх (1) или вниз (0) считает
    output logic [7:0] out
);

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin 
    out <= 8'b00000000;
    end
    else begin
        if (load) begin 
        out <= d;
        end 
        else begin 
            if (direction) begin 
            out <= out + 1;
            end 
            else begin 
                out <= out - 1;
            end
        end
    end
end

endmodule

//Опишите на Verilog HDL 8-разрядный сумматор при помощи непрерывного и 
//процедурного присваивания. 

module plis(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

assign out = a + b; //непрерывное 

always_comb begin //процедруное 
    out = a + b; 
end 

endmodule 

//Опишите на Verilog HDL дешифратор 4 в 7 с асинхронным сбросом и 
//синхронной загрузкой значения.

module plis(
    input logic [3:0] data,
    input clk,
    input logic rst,
    output logic [6:0] out 
);

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin 
    out <= 7'b0000000;
    end
    else begin 
            case(data) 
            4'b0000: out <= 7'b0111111; 
            4'b0001: out <= 7'b0000110;
            4'b0010: out <= 7'b1011011;
            4'b0011: out <= 7'b1001111;
            4'b0100: out <= 7'b1100110;
            4'b0101: out <= 7'b1101101;
            4'b0110: out <= 7'b1111101;
            4'b0111: out <= 7'b0000111;
            4'b1000: out <= 7'b1111111;
            4'b1001: out <= 7'b1101111;
            default: out <= 7'b0000000;
            endcase           
    end 
end

endmodule 

//1.Опишите на Verilog HDL 16-разрядный счетчик с асинхронным сбросом и 
//синхронной загрузкой начального значения.

module plis(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [15:0] data,
    output logic [15:0] counter 
);

always_ff @(posedge clk or negedge rst) begin 
    if (!rst) begin 
        counter <= 16'h0; 
    end
    else begin 
        if (load) begin 
            counter <= data;
        end 
        else begin
            counter <= counter + 1;
        end 
    end
end 
endmodule

//2.Опишите на Verilog HDL 32-разрядный счетчик с синхронным сбросом и 
//асинхронной загрузкой начального значения.
module plis(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [31:0] data,
    output logic [31:0] counter 
);

always_ff @(posedge clk or posedge load) begin 
    if (load) begin 
        counter <= data;
    end 
    else begin 
        if (rst) begin 
            counter <= 32'h0;
        end 
        else begin 
            counter <= counter + 1;
        end     
    end
end 

endmodule 

//3.Опишите на Verilog HDL счетчик до 500 с асинхронным сбросом и 
//синхронной загрузкой начального значения.

module plis (
    input logic clk,
    input logic rst,
    input logic load,
    input logic [8:0] data,
    output logic [8:0] counter 
);

always_ff @(posedge clk or posedge rst) begin 
    if (rst) begin 
        counter <= '0;
    end 
    else begin 
        if (load && data < 500) begin 
            counter <= data;
        end 
        else begin 
            if (load && data >= 500) begin 
            counter <= counter;
            end 
            else begin 
            if (counter < 500) begin 
                counter <= counter + 1; 
            end 
            else begin 
                counter <= '0;
            end    
        end 
    end 
end 
end 

endmodule

//4.Опишите на Verilog HDL 8-разрядный сумматор с накоплением и синхронным 
//сбросом.

module plis (
    input logic clk,
    input logic rst,
    input logic [7:0] data,
    output logic [7:0] out 
);

always_ff @(posedge clk) begin 
    if (rst) begin 
        out <= '0;
    end
    else begin 
        out <= out + data;
    end  
end 

endmodule

//5.Опишите на Verilog HDL 8-разрядный буфер с третьим состоянием, расскажите о 
//его назначении.

module plis (
    input logic output_enable,
    input logic [7:0] in,
    output logic [7:0] out 
);

assign out =  (output_enable) ? in : 1'bz;

endmodule 

//6.Опишите на Verilog HDL 8-разрядный сдвиговый регистр при помощи 
//процедурного присваивания и оператора объединения, реализовав возможность 
//выбора направления сдвига.

module plis (
    input logic clk,
    input logic dir, 
    input logic in,
    output logic [7:0] out 
);

always_ff @(posedge clk) begin 
    if (!dir) begin 
        out <= {out[6:0], in}; 
     end 
     else begin 
        out <= {in, out[7:1]}; 
     end 
end    

endmodule 

//7.Опишите на Verilog HDL 8-разрядный сдвиговый регистр с синхронным 
//сбросом и асинхронной параллельной загрузкой при помощи процедурного 
//присваивания и оператора объединения.

module plis(
    input logic data,
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] load_value,
    output logic [7:0] out
);

always_ff @(posedge clk or posedge load) begin 
    if(load) begin 
        out <= load_value;
    end 
    else begin 
        if(rst) begin 
            out <= '0; 
        end 
        else begin 
            out <= {out[6:0], data};
        end 
    end 
end 

endmodule 

//8.Опишите на Verilog HDL модуль, вычисляющий бит четности 32-разрядного 
//слова при помощи оператора свертки. Проиллюстрируйте его работу с помощью 
//временных диаграмм. Модуль должен иметь полностью синхронную структуру. 
//Ввод числа производится по сигналу WR. Сброс асинхронный. 

module plis(
    input logic clk, 
    input logic WR,
    input logic rst,
    input logic [31:0] data,
    output logic chet
);

always_ff @(posedge  clk or posedge rst) begin 
    if (rst) begin 
        chet <= '0; 
    end
    else begin 
        if (WR) begin 
            chet <= ^data;
        end 
    end  
end 
endmodule 

//10.Опишите на Verilog HDL 8-разрядный сдвиговый регистр с асинхронным 
//сбросом и синхронной параллельной загрузкой при помощи процедурного 
//присваивания и оператора объединения. Направление сдвига определяется 
//сигналом dir. 

module plis(
    input logic clk,
    input logic rst, 
    input logic dir,
    input logic data,
    input logic load,
    input logic [7:0] load_value,
    output logic [7:0] out
); 

always_ff @(posedge clk or posedge rst) begin 
    if (rst) begin 
        out <= '0;
    end     
    else begin 
        if (load) begin 
            out <= load_value;
        end 
        else begin 
            if (dir) begin 
                out <= {out[6:0], data};    
            end 
            else begin 
                out <= {data, out[7:1]};
            end 
        end 
    end 
end 

endmodule 

//11.Опишите на Verilog HDL счётчик до 60 с асинхронным сбросом и синхронной 
//загрузкой начального значения.

module plis(
    input logic clk,
    input logic rst, 
    input logic [5:0] load_value,
    input logic load,
    output logic [5:0] counter
);

always_ff @(posedge clk or posedge rst) begin 
    if (rst) begin 
        counter <= '0;
    end 
    else begin 
        if (load & counter < 60) begin 
            counter <= load_value;
        end 
        else begin 
            if (load & counter >= 60) begin 
                counter <= '0;
            end 
            else begin 
                if (counter < 60) begin 
                    counter <= counter + 1;
                end 
                else begin 
                    counter <= '0;
                end 
            end 
        end 
    end 
end 

endmodule 