module up_counter(input clk_pad, reset_pad, output[3:0] counter_pad);
    reg [3:0] counter_up;          
    wire clk, clk_b, reset;
    wire [3:0] counter;
    always @(posedge clk or posedge reset)          
    begin
        if(reset)
            begin
                counter_up = 4'd0;                  
            end
        else
            begin
                counter_up = counter_up + 4'd1;     
            end       
    end 
    assign counter = counter_up;                    

// ADD INPUT OUTPUT PADS
pc3d01 pc3d01_1 (.PAD(clk_pad), .CIN(clk_b));
pc3c01 pc3c01_1 (.CCLK(clk_b), .CP(clk));
pc3d01 pc3d01_2 (.PAD(reset_pad), .CIN(reset));
pc3o05 pc3o05_1(.I (counter[3]), .PAD (counter_pad[3]));
pc3o05 pc3o05_2(.I (counter[2]), .PAD (counter_pad[2]));
pc3o05 pc3o05_3(.I (counter[1]), .PAD (counter_pad[1]));
pc3o05 pc3o05_4(.I (counter[0]), .PAD (counter_pad[0]));

endmodule


