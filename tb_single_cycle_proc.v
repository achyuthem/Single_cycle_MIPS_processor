module single_cycle_tb;

reg clock;

single_cycle_processor s1 (clock);

initial clock = 0;

always
	#50 clock=~clock;

initial begin
	#3200 $finish;

end

endmodule
