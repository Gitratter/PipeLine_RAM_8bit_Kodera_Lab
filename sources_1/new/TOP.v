module TOP(clk, reset, clksel, in, clk_ind, pipe_ind0, pipe_ind1, pipe_ind2, pipe_ind3, out);
    input clk;
    input reset;
    input clksel;
    input [7:0]in;
    output reg [3:0]clk_ind;
    output reg pipe_ind0;
    output reg pipe_ind1;
    output reg pipe_ind2;
    output reg pipe_ind3;
    output reg [7:0]out;

    //クロック切替
    wire clk_1Hz, clk_10Hz, clkt;
    assign clkt = (clksel == 1'b1)? clk_10Hz : clk_1Hz;
    gen_1Hz gen1 (.clk(clk),.reset(reset), .clk_1Hz(clk_1Hz));
    gen_10Hz gen10 (.clk(clk),.reset(reset), .clk_10Hz(clk_10Hz));

    reg [7:0]reg_A = 8'b00000000;
    reg [7:0]reg_B = 8'b00000000;  
    reg carry_flag = 1'b0;

    //======パイプライン制御
    reg [1:0]stage_ctrl;
    always@(posedge clkt or posedge reset)begin
        if(reset)begin
            stage_ctrl <= 0;
        end else if(stage_ctrl != 3)begin
            stage_ctrl <= stage_ctrl + 1;
        end
    end

    //=====STAGE 1 : Instruction Fetch
    reg [3:0]pcnt = 4'b0000;
    wire [12:0]command;
    ROM rom(.pcnt(pcnt), .command(command));

    //---IF/ID  パイプラインレジスタ -----
    reg [12:0]if_id_command;
    
    always@(posedge clkt or posedge reset)begin
        if(reset)begin
            if_id_command <= 13'b0000000000000;
            pipe_ind0 <= 0; //パイプラインインジケーターリセット 0
        end else begin
            if_id_command <= command;
            pipe_ind0 <= 1; //パイプラインインジケーター 0
        end
    end


    
    //=====STAGE 2 : Instruction Decode
    wire [10:0]id_instr;
    wire [4:0]id_opcode = if_id_command[12:8];
    wire [7:0]id_im = if_id_command[7:0];
    DECODER decoder(.opcode(id_opcode), .carry(carry_flag), .instr(id_instr));

    //---ID/EX  パイプラインレジスタ -----
    reg [10:0]id_ex_instr;
    reg [7:0]id_ex_im;
    reg [7:0]id_ex_reg_A_data;
    reg [7:0]id_ex_reg_B_data;
    reg [7:0]id_ex_in_data;
    
    always@(posedge clkt or posedge reset)begin  //Positive edge
        if(reset || stage_ctrl < 1)begin  //ステージ制御
            id_ex_instr <= 11'b11111111111;
            id_ex_im <= 8'b00000000;
            pipe_ind1 <= 0; //パイプラインインジケーターリセット 1
        end else begin
            id_ex_instr <= id_instr;
            id_ex_im <= id_im;
            pipe_ind1 <= 1; //パイプラインインジケーター 1
        end
    end

    always@(negedge clkt or posedge reset)begin  //Negative edge レジスタ読み込み
        if(reset || stage_ctrl < 1)begin  //ステージ制御
            id_ex_reg_A_data <= 8'b00000000;
            id_ex_reg_B_data <= 8'b00000000;
            id_ex_in_data <= 8'b00000000; 
        end else begin
            id_ex_reg_A_data <= reg_A;
            id_ex_reg_B_data <= reg_B;
            id_ex_in_data <= in; 
        end
    end



    //=====STAGE 3 : Execute
    wire [1:0]ex_select = {id_ex_instr[10], id_ex_instr[9]};

    //----EX/WB パイプラインレジスタ ----
    reg [7:0]ex_wb_alu_data;
    reg        ex_wb_carry_wire;
    reg [3:0]ex_wb_load_instr;

    reg        ex_wb_memload;
    reg [1:0]ex_wb_memtarget;
    reg        ex_wb_memstore;

    wire need_src_A = (ex_select == 2'b00);
    wire need_src_B = (ex_select == 2'b01);
    wire exwb_will_write_A = (ex_wb_load_instr[3] == 1'b0);
    wire exwb_will_write_B = (ex_wb_load_instr[2] == 1'b0);
    wire use_fwd_A_from_wb = need_src_A && exwb_will_write_A;
    wire use_fwd_B_from_wb = need_src_B && exwb_will_write_B;
    wire [7:0]srcA_for_selector = use_fwd_A_from_wb ? ex_wb_alu_data : id_ex_reg_A_data;
    wire [7:0]srcB_for_selector = use_fwd_B_from_wb ? ex_wb_alu_data : id_ex_reg_B_data;

    wire [7:0]ex_select_data;
    SELECTOR selector(
        .select(ex_select),
        .reg_A(srcA_for_selector),
        .reg_B(srcB_for_selector),
        .in(id_ex_in_data),
        .select_data(ex_select_data)
    );

    wire [7:0]ex_alu_data;
    wire        ex_carry_wire;
    wire        ex_alu_sel = id_ex_instr[4];
    ALU alu(.ALUsel(ex_alu_sel), .select_data(ex_select_data), .im(id_ex_im), .ALU_data(ex_alu_data), .carry(ex_carry_wire));

    //--------
    //Data RAM (256 words * 8bit)
    //--------

    wire [7:0]ram_dout;
    reg        ram_we;
    wire [7:0]ram_addr = id_ex_im;
    reg [7:0]ram_din;

    always@(*)begin  
        ram_din = 8'b00000000;
        if(id_ex_instr[2])begin  //MemStore
            case(id_ex_instr[1:0])
                2'b00 : ram_din = srcA_for_selector;
                2'b01 : ram_din = srcB_for_selector;
                2'b10 : ram_din = out;
                default : ram_din = srcA_for_selector;
            endcase
        end else begin
            ram_din = 8'b00000000;
        end
    end
    
    always@(*)begin  
        ram_we = id_ex_instr[2];
    end

    RAM data_ram(
        .clk(clkt),
        .we(ram_we),
        .addr(ram_addr[7:0]),
        .din(ram_din),
        .dout(ram_dout)
    );

    //EX/WB  パイプラインレジスタ更新
    always@(posedge clkt or posedge reset)begin  
        if(reset || stage_ctrl < 2)begin  
            ex_wb_alu_data <= 8'b00000000;
            ex_wb_carry_wire <= 1'b0;
            ex_wb_load_instr <= 4'b1111; 
            ex_wb_memload <= 1'b0;
            ex_wb_memtarget <= 2'b00;
            ex_wb_memstore <= 1'b0;
            pipe_ind2 <= 0;
        end else begin
            ex_wb_alu_data <= ex_alu_data;
            ex_wb_carry_wire <= ex_carry_wire;
            ex_wb_load_instr <= id_ex_instr[8:5]; 
            ex_wb_memload <= id_ex_instr[3];
            ex_wb_memstore <= id_ex_instr[2];
            ex_wb_memtarget <= id_ex_instr[1:0];
            pipe_ind2 <= 1;
        end
    end
    


    //=====STAGE 4 : Write Back
    wire wb_load0 = ex_wb_load_instr[3];
    wire wb_load1 = ex_wb_load_instr[2];
    wire wb_load2 = ex_wb_load_instr[1];
    wire wb_load3 = ex_wb_load_instr[0];

    always@(posedge clkt or posedge reset)begin  
        if(reset)begin  
            reg_A <= 8'b00000000;
            reg_B <= 8'b00000000;
            out   <= 8'b00000000; 
            carry_flag <= 1'b0;
            pipe_ind3 <= 0;
        end else if(stage_ctrl >= 3)begin
            if(ex_wb_memload)begin
                case(ex_wb_memtarget)
                    2'b00 : reg_A <= ram_dout;
                    2'b01 : reg_B <= ram_dout;
                    2'b10 : out   <= ram_dout;
                    default: ;
                endcase
            end else begin
                if(~wb_load0) reg_A <= ex_wb_alu_data;
                if(~wb_load1) reg_B <= ex_wb_alu_data;
                if(~wb_load2) out   <= ex_wb_alu_data;
            end
            carry_flag <= ex_wb_carry_wire;
            pipe_ind3 <= 1;
        end
    end
    
    always@(posedge clkt or posedge reset)begin  
        if(reset)begin  
            pcnt <= 4'b0000;
        end else begin
            if((~wb_load3) && (stage_ctrl >= 3))begin
                pcnt <= ex_wb_alu_data;
            end else begin
                pcnt <= pcnt + 1'b1;
            end
        end
    end

    always@(posedge clkt or posedge reset)begin  
        if(reset)begin  
            clk_ind <= 0;
        end else begin
            if(clk_ind >= 4'b1111)
                clk_ind <= 0;
            else
                clk_ind <= clk_ind + 1;
        end
    end
endmodule
