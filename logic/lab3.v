module lab_3
 (
	input axis_clk,
	input axis_reset,
	input [3:0] write,
	output reg [3:0] read, //read is the frequency of the number what we force in 'input write'
	//AXIS--Anvanced Extensible Interfase Stream-- slave
	input s_axis_valid,
	input [3:0] s_axis_data,
	output s_axis_ready,
	//AXIS--Anvanced Extensible Interfase Stream-- master 
	output reg m_axis_valid,
	output [3:0] m_axis_data,
	input m_axis_ready
 );
 
	assign s_axis_ready = m_axis_ready;
	
	reg [3:0] address [0:9];
	integer i;
	initial 
		for(i=0; i<10; i=i+1)
		begin
			address[i]=4'd0;
		end

	
	always @(posedge axis_clk) 
	begin
	if(m_axis_valid==1)
		begin
			if(axis_reset)
			begin
				for(i=0;i<10;i=i+1)
				begin
				address[i]=4'd0;
				end
			end 
			else begin 
				if(m_axis_data == 4'd0)
					address[4'd0] <= address[4'd0]+4'd1;
					if(m_axis_data == 4'd1) 
					address[4'd1] <= address[4'd1]+4'd1;
						if(m_axis_data == 4'd2) 
						address[4'd2] <= address[4'd2]+4'd1;
							if(m_axis_data == 4'd3)
							address[4'd3] <= address[4'd3]+4'd1;
								if(m_axis_data == 4'd4)
								address[4'd4] <= address[4'd4]+4'd1;	
									if(m_axis_data == 4'd5) 
									address[4'd5] <= address[4'd5]+4'd1;
										if(m_axis_data == 4'd6) 
										address[4'd6] <= address[4'd6]+4'd1;
											if(m_axis_data == 4'd7) 
											address[4'd7] <= address[4'd7]+4'd1;
												if(m_axis_data == 4'd8)
												address[4'd8] <= address[4'd8]+4'd1;
													if(m_axis_data == 4'd9)  
													address[4'd9] <= address[4'd9]+4'd1;
													else begin
													read <= address[write];
													end
			end									
	end	
	end
	//in order to master's valid to be high, slave's ready and valid should be high 
	always @(posedge axis_clk)
	begin 
		m_axis_valid <= s_axis_ready & s_axis_valid;
	end
	
	//if master's valid is high, then the data received is equal to the data transmitted 
//	always @(posedge axis_clk)
//	if(m_axis_valid)
//	begin 
//		s_axis_data = m_axis_data;
//	end
	
 
 endmodule 