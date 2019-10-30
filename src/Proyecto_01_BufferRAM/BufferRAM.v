`timescale 1ns / 1ps

module BufferRAM(AW,DW,File)(clk,inadr,indata,regwrite,outadr,outdata,regread);
	
	parameter AW = 15;
	parameter DW = 16;
	parameter File = ".image.men";
	
	input  clk;
	input  [AW-1: 0] inadr;
	input  [DW-1: 0] indata;
	input  regwrite;
	
	output reg [DW-1: 0] outdata;
	input [AW-1: 0] out;
	input regread;
	
endmodule

module buffer_ram_dp#( 
	parameter AW = 15, // Cantidad de bits  de la dirección 
	parameter DW = 16, // cantidad de Bits de los datos 
	parameter   imageFILE= "./image.men")
	(  
	input  clk, 
	input  [AW-1: 0] addr_in, 
	input  [DW-1: 0] data_in,
	input  regwrite, 
	
	output reg [DW-1: 0] data_out,
	input [AW-1: 0] addr_out, 
	input regread
	);

//-- Calcular el numero de posiciones totales de memoria 
localparam NPOS = 2 ** AW; //-- Memoria

 reg [DW-1: 0] ram [0: NPOS-1]; 

//-- Lectura/escritura  de la memoria port 1 
always @(posedge clk) begin 
       if (regwrite == 1) 
             ram[addr_in] <= data_in;
end

//-- Lectura/escritura  de la memoria port 2 
always @(posedge clk) begin 
       if (regread == 1) 
           data_out <= ram[addr_out]; 
end
 
initial begin
	$readmemh(imageFILE, ram);
end

endmodule