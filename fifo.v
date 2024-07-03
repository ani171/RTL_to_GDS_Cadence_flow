//-----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//-----%% Project Name : Asynchronous FIFO Design                                                       %%
//-----%% File Name    : fifo.v                                                                         %%
//-----%% Author       : CDAC Bangalore                                                                 %%
//---- %%                                                                                               %%
//-----%% Description  : In this design,we are passing the data from write clock domain to read clock   %%
//-----%%                domain. Two operations are supported, PUSH and POP.Whenever i_wr_en is logic   %%
//-----%%                HIGH, PUSH operation is performed on i_wr_data. Also,whenever i_rd_en is       %%
//-----%%                logic HIGH, POP operation is performed and data will be available in o_rd_data.%%
//-----%%                FULL (o_full) and EMPTY(o_empty) flags are generated to indicate the           %%
//-----%%                status of the FIFO.                                                            %%
//-----%%                In this module fifo represents a asynchronous FIFO memory with read and write  %%
//-----%%                operations synchronized to different clock domains. The module includes        %%
//-----%%                parameters for data size (DATASIZE), address size (ADDRSIZE), and memory depth %%
//-----%%                (MEM_DEPTH). It features input ports for write data (i_wr_data), write clock   %%
//-----%%                (i_wr_clk), write reset (i_wr_rst_n), write enable (i_wr_en), read clock       %%
//-----%%                (i_rd_clk), read reset (i_rd_rst_n), and read enable (i_rd_en).                %%
//-----%%                The outputs include read data (o_rd_data), full flag (o_full), and empty flag  %%
//-----%%                (o_empty).                                                                     %%
//-----%%                Within the reset_sync module, synchronized write and read reset signals        %%
//-----%%                (sync_wr_rst and sync_rd_rst) are generated using the reset_sync module. The   %%
//-----%%                write and read pointers are synchronized to the opposing clock domains using   %%
//-----%%                sync_ptr_clx modules, ensuring proper data transfer between clock domains.     %%
//-----%%                The memory itself is implemented using the fifo_mem module, which manages read %%
//-----%%                and write addresses, read and write data, and full flag logic.                 %%
//-----%%                The fifo_empty and fifo_full modules handle empty and full conditions,         %%
//-----%%                respectively, based on the synchronized read and write pointers.               %%
//-----%%                Overall, the fifo module provide asynchronized FIFO memory structure, allowing %%
//-----%%                reliable communication between different clock domains while efficiently       %%
//-----%%                managing read and write operations. The use of synchronization and proper flag %%
//-----%%                logic ensures the correct functioning of the FIFO memory in asynchronous clock %%
//-----%%                environments.                                                                  %%
//-----%% Copyright    : CDAC Bangalore                                                                 %%
//-----%%                                                                                               %%
//-----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//-----%%%%%%%%%%%%%%%%% Modification / Updation History %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//-----%%                                                                                               %%
//-----%% Date: 11-12-2023              Version: 1.0   Change Description:                              %%
//-----%%                                                                                               %%
//-----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

module fifo(o_rd_data_pad                                            ,
	    o_full_pad                                               ,
	    o_empty_pad                                              ,
	    i_wr_data_pad                                            ,
	    i_wr_en_pad                                              ,
	    i_wr_clk_pad                                             ,
	    i_wr_rst_n_pad                                           ,
	    i_rd_en_pad                                              ,
	    i_rd_clk_pad                                             ,
	    i_rd_rst_n_pad     )                                     ;

//parameter declaration
parameter DATASIZE    = 8                                       ;
parameter ADDRSIZE    = 4                                       ;
parameter MEM_DEPTH   = 16                                      ;
 
                             
//input declarations
input   [DATASIZE-1:0] i_wr_data_pad                                 ;	//data that is given into the fifo with respect to write clock
input                 i_wr_clk_pad                                   ;       //clock from write domain
input                 i_wr_rst_n_pad                                 ;	//active low reset of write domain 
input                 i_wr_en_pad                                    ;	//enable for the write operation
input                 i_rd_clk_pad                                   ;	//clock from read domain
input                 i_rd_rst_n_pad                                 ;	//active low reset of read domain
input                 i_rd_en_pad                                    ;	//enable for read operation


//output declarations
output [DATASIZE-1:0] o_rd_data_pad                                  ;	//data that id read from the fifo
output                o_full_pad                                     ;	//full flag indictaing the fifo is full
output                o_empty_pad                                    ;       //empty flag indicating fifo is empty

wire [DATASIZE-1:0] i_wr_data;
wire i_wr_en, i_wr_clk, i_wr_rst_n, i_rd_en,  i_rd_clk, i_rd_rst_n, read_clk, write_clk;
wire [DATASIZE-1:0] o_rd_data;
wire o_full, o_empty;
	   
	   
  pc3c01 pc3c01_1(.CCLK (read_clk), .CP (i_rd_clk));
  pc3c01 pc3c01_2(.CCLK (write_clk), .CP (i_wr_clk));

  pc3d01 pc3d01_1(.PAD (i_rd_clk_pad), .CIN (read_clk));
  pc3d01 pc3d01_2(.PAD (i_wr_clk_pad), .CIN (write_clk));

  pc3d01 pc3d01_3(.PAD (i_wr_rst_n_pad), .CIN (i_wr_rst_n));
  pc3d01 pc3d01_4(.PAD (i_rd_rst_n_pad), .CIN (i_rd_rst_n));

  pc3d01 pc3d01_5(.PAD (i_wr_en_pad), .CIN (i_wr_en));
  pc3d01 pc3d01_6(.PAD (i_rd_en_pad), .CIN (i_rd_en));

  pc3d01 pc3d01_7(.PAD (i_wr_data_pad[7]), .CIN (i_wr_data[7]));
  pc3d01 pc3d01_8(.PAD (i_wr_data_pad[6]), .CIN (i_wr_data[6]));
  pc3d01 pc3d01_9(.PAD (i_wr_data_pad[5]), .CIN (i_wr_data[5]));
  pc3d01 pc3d01_10(.PAD (i_wr_data_pad[4]), .CIN (i_wr_data[4]));
  pc3d01 pc3d01_11(.PAD (i_wr_data_pad[3]), .CIN (i_wr_data[3]));
  pc3d01 pc3d01_12(.PAD (i_wr_data_pad[2]), .CIN (i_wr_data[2]));
  pc3d01 pc3d01_13(.PAD (i_wr_data_pad[1]), .CIN (i_wr_data[1]));
  pc3d01 pc3d01_14(.PAD (i_wr_data_pad[0]), .CIN (i_wr_data[0]));


  pc3o05 pc3o05_1(.I (o_rd_data[7]), .PAD (o_rd_data_pad[7]));
  pc3o05 pc3o05_2(.I (o_rd_data[6]), .PAD (o_rd_data_pad[6]));
  pc3o05 pc3o05_3(.I (o_rd_data[5]), .PAD (o_rd_data_pad[5]));
  pc3o05 pc3o05_4(.I (o_rd_data[4]), .PAD (o_rd_data_pad[4]));
  pc3o05 pc3o05_5(.I (o_rd_data[3]), .PAD (o_rd_data_pad[3]));
  pc3o05 pc3o05_6(.I (o_rd_data[2]), .PAD (o_rd_data_pad[2]));
  pc3o05 pc3o05_7(.I (o_rd_data[1]), .PAD (o_rd_data_pad[1]));
  pc3o05 pc3o05_8(.I (o_rd_data[0]), .PAD (o_rd_data_pad[0]));
 
  pc3o05 pc3o05_9(.I (o_full), .PAD (o_full_pad));
  pc3o05 pc3o05_10(.I (o_empty), .PAD (o_empty_pad));

//wire declaration
wire   [ADDRSIZE-1:0] wr_addr_s                                 ;       //wire for write address 
wire   [ADDRSIZE-1:0] rd_addr_s                                 ;	//wire for read address 
wire   [ADDRSIZE:0]   wr_ptr_s                                  ;	//wire of write pointer
wire   [ADDRSIZE:0]   rd_ptr_s                                  ;	//wire of read pointer
wire   [ADDRSIZE:0]   wr_ptr_clx                                ;	//wire for synchronized write signal
wire   [ADDRSIZE:0]   rd_ptr_clx                                ;       //wire for synchronized read  signal
wire                  sync_wr_rst                               ;       //synchronized write reset
wire                  sync_rd_rst                               ;       //synchronized read reset

//synchronous read reset
reset_sync     u_rd_reset_sync  (.i_clk(i_rd_clk)               ,
                                 .i_rst_n(i_rd_rst_n)           ,
                                 .o_sync_rst(sync_rd_rst)     
                                )                               ;

//synchronous write reset
reset_sync     u_wr_reset_sync  (.i_clk(i_wr_clk)               ,
                                 .i_rst_n(i_wr_rst_n)           ,
                                 .o_sync_rst(sync_wr_rst)
                                )                               ;
 


//read pointer synchronizing to write clock
sync_ptr_clx   #( .ADDRSIZE(ADDRSIZE))
               u_sync_rd2wr_clx (.o_ptr_clx(rd_ptr_clx)         , 
		                 .i_ptr(rd_ptr_s)               ,
 		                 .i_clk(i_wr_clk)               , 
		                 .i_rst_n(sync_wr_rst)
                                )                               ;

//write pointer synchronizing to read clock
sync_ptr_clx   #( .ADDRSIZE(ADDRSIZE))
               u_sync_wr2rd_clx (.o_ptr_clx(wr_ptr_clx)         , 
		                 .i_ptr(wr_ptr_s)               ,
		                 .i_clk(i_rd_clk)               , 
		                 .i_rst_n(sync_rd_rst) 
			        )                               ;

//memory module of fifo
fifo_mem       #( .DATASIZE(DATASIZE), .ADDRSIZE(ADDRSIZE), .MEM_DEPTH(MEM_DEPTH))
               u_fifo_mem       (.o_rd_data(o_rd_data)          , 
		                 .i_wr_data(i_wr_data)          ,
 		                 .i_wr_addr(wr_addr_s)          , 
		                 .i_rd_addr(rd_addr_s)          ,
     		                 .i_wr_en(i_wr_en)              , 
		                 .i_full(o_full)                ,
 		                 .i_wr_rst_n(sync_wr_rst)       ,
                                 .i_wr_clk(i_wr_clk)
		                )                               ;

//fifo empty logic module
fifo_empty     #( .ADDRSIZE(ADDRSIZE))
               u_fifo_empty     (.o_empty(o_empty)              ,
 		                 .o_rd_addr(rd_addr_s)          ,
 		                 .o_rd_ptr(rd_ptr_s)            , 
		                 .i_wr_ptr_clx(wr_ptr_clx)      ,
		                 .i_rd_en(i_rd_en)              ,
		                 .i_rd_clk(i_rd_clk)            ,
 	                         .i_rd_rst_n(sync_rd_rst)
		                )                               ;

//fifo full logic module
fifo_full      #( .ADDRSIZE(ADDRSIZE))
               u_fifo_full      (.o_full(o_full)                ,
		                 .o_wr_addr(wr_addr_s)          ,
		                 .o_wr_ptr(wr_ptr_s)            , 
		                 .i_rd_ptr_clx(rd_ptr_clx)      ,
		                 .i_wr_en(i_wr_en)              , 
		                 .i_wr_clk(i_wr_clk)            ,
		                 .i_wr_rst_n(sync_wr_rst)
		                )                               ;

endmodule
