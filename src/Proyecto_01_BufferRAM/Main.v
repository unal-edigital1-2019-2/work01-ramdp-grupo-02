`timescale 1ns / 1ps

module Main(
	
	input  clk,
	output [15: 0] data_out,
	input [16: 0] addr_out, 
	input regread
	);
	
	buffer_ram_dp RAM (
		.clk(clk), 
		.addr_in(0), 
		.data_in(0), 
		.regwrite(0), 
		.data_out(data_out), 
		.addr_out(addr_out), 
		.regread(regread)
	);
	
endmodule
