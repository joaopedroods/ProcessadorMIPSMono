/*
================================================================================
==                        Informações do Projeto                        ==
================================================================================
Disciplina:   Arquitetura e Organização de Computadores (2025.1)
Professor:    Vítor A. Coutinho
Projeto:      Implementação de um Processador MIPS Monociclo (Projeto da 2ª VA)
Grupo:
              - Giovanna Neves
              - João Pedro Oliveira da Silva
              - José Albérico
              - Lucas Lins

================================================================================
==                        Informações do Arquivo                        ==
================================================================================
Arquivo:      ProcessadorMIPSMono.v
Módulo:       ProcessadorMIPSMono

Descrição:
              Este é o módulo Top-Level do processador MIPS monociclo. Ele é
              responsável por instanciar e interconectar todos os componentes
              do caminho de dados e da unidade de controle, formando o
              processador completo. As saídas expostas são para fins de
              depuração e verificação no testbench.
================================================================================
*/
module ProcessadorMIPSMono(ula_in1, ula_in2, ALU_out, d_mem_out, PC_out, clock, reset_global);

	//Descrição das entradas e saídas:
	input wire clock;                // sinal do clock
	input wire reset_global;			         // sinal do reset
	output wire [31:0] PC_out; 		// saida do pc
	output wire [31:0] ALU_out; 		// saida da ula
	output wire [31:0] d_mem_out; 	// saida da d_mem
	output wire [31:0] ula_in1, ula_in2; //entradas da ula (apenas para teste)
	
	//Declaração dos cabos relacionado aos módulos:
	wire [31:0] cabo_PC_out; 						 			// cabo da saída do PC que conecta com outros 2 módulos (i_men e somador_pc_4)
	wire [31:0] cabo_somador_PC_4_out;     	 			// cabo da saída do somador do pc + 4 que conecta com outros 2 módulos (somador_pc_jump e mux_PC_next)
	wire [31:0] cabo_shift_left_2_para_somador_PC_jump;// Cabo de saída do Shift Left 2 que conecta com o somador_PC_jump
	wire [31:0] cabo_somador_PC_jump_para_mux_PC_next; // cabo de saída do cabo_somador_PC que conecta com mux_PC_next
	wire [31:0] cabo_mux_PC_next_para_PC;      			// cabo de saída do mux_PC_next que conecta com PC contendo o próximo valor do PC
	wire [31:0] cabo_i_men_out; 					 			// cabo de saída do i_men (esse cabo sera dividido em trocentas partes)
	wire [31:0] cabo_extensor_de_sinal_out; 	 			// cabo de saída do extensor de sinal que conecta 2 módulos (mux_in_2_ALU e shif_left_2)
	wire [31:0] cabo_mux_dest_reg_para_regfile;      	// cabo de saída do mux_dest_reg que conecta com regfile
	wire cabo_and_out;                         			// cabo de saída do and que sinaliza se irá ter um jump
	wire [31:0] cabo_mux_valor_write_data;					// cabo de saída do mux_valor_write_data que diz qual valor a ser escrito no reg destino
	wire [31:0] cabo_mux_in_2_ALU;							// cado de saída do mux_in_2_ALU que diz qual o 2º operando da ALU
	wire [31:0] cabo_mux_in_1_ALU;
	
	//Declaração do conjunto de cabos do i_men que conecta com 4 módulos (control, regfile, mux_dest_reg, extensor_de_sinal)
	wire [5:0] cabo_opcode, cabo_funct; 					 // cabos dos bits para opcode e funct
	wire [4:0] cabo_rs, cabo_rt, cabo_rd, cabo_Shamt;   // cabos dos bit para rs, rt, rd, shamt
	wire [15:0] cabo_extensor_de_sinal;                 // cabo para o extensor de sinal
	
	//separador dos campos da instrução vinda do cabo_i_men_out
	assign cabo_opcode = cabo_i_men_out[31:26];  				// separa os bits para opcode
	assign cabo_rs = cabo_i_men_out[25:21];  						// separa os bits para rs
	assign cabo_rt = cabo_i_men_out[20:16];  						// separa os bits para rt
	assign cabo_rd = cabo_i_men_out[15:11];  						// separa os bits para rd
	assign cabo_funct = cabo_i_men_out[5:0];   					// separa os bits para funct
	assign cabo_extensor_de_sinal = cabo_i_men_out[15:0];  	// separa os bits para extensor de sinal
	assign cabo_Shamt = cabo_i_men_out[10:6];
	
	// Cabos saídos do banco de registradores
	wire [31:0] valor_reg1;
	wire [31:0] valor_reg2;
	wire [4:0] cabo_mux_dest_reg_regfile;
	
	// Cabo do valor lido da memória
	wire [31:0] cabo_d_mem_out;
	 
	//Declaração do conjunto de cabos da unidade de controle:
	wire RegDst; 
	wire Branch;
	wire MemRead;	
	wire MemToReg;
	wire [3:0] ALUOp;
	wire MemWrite; 
	wire ALUSrc;
	wire RegWrite; 
	wire Link;
	wire Jump;
	
	// Declaração dos cabos da ULA:
	wire cabo_zero;
	wire [31:0] cabo_ALU_out;
	
	//Declaração de cabos da ULA ctrl:
	wire [3:0] alu_ctrl_out;
	wire Shamt;
	
	assign cabo_and_out = Branch & cabo_zero;
	
	//Declaração dos módulos:
	
	//Declaração da instância do PC
	PC pc(
        .clock (clock),                       // Entrada: Cabo que contém o clock   
        .nextPC (cabo_mux_PC_next_para_PC),  // Entrada: cabo de saída do mux_PC_next contendo o valor do próximo pc
        .PC (cabo_PC_out)//,                            // Saida:   cabo de saída do PC que possui o endereco atual do PC
        //.Reset(reset_global)
    );
	
	i_mem Imem(
		.address(cabo_PC_out),      // Entrada: cabo que possui o valor atual do PC
		.i_out(cabo_i_men_out)  // Saída:   cabo que contém a intrução correspondente ao valor do PC
	);
	
	//Declaração  do somador do pc + 4
	adder_PC_4 somador_pc4(            		
		.PC_in(cabo_PC_out),                    	// Entrada: Cabo que contem o valor atual do PC
		.PC_out(cabo_somador_PC_4_out)    // Saida:   Cabo de saída do somador que possui o valor do PC + 4
	);
	
	//Declaração  do somador do pc 
	adder_PC_jump somador_jump(
		.endereco_PC(cabo_somador_PC_4_out),                         // Entrada:  Cabo que possui o valor do PC + 4
		.endereco_deslocado(cabo_shift_left_2_para_somador_PC_jump), // Entrada:  cabo que possui o endereço com 2 bits deslocado
		.endereco_jump(cabo_somador_PC_jump_para_mux_PC_next)        // Saida:    cabo que possui o novo endereco do PC
	);
	
	//Declaração da instância do shift left 2
	shift_left_2 sll2(
		.in(cabo_extensor_de_sinal_out),              // Entrada: cabo de saída do extensor de sinal, contendo o endereço em 32 bits
		.out(cabo_shift_left_2_para_somador_PC_jump)  // Saída: 	 cabo de saída que contem o endereço 2 bits deslocado que vai para somardor_PC_jump  
	);
	
	//Declaração da instância do extensor de sinal
	extensor_sinal extensor  (
		.in(cabo_extensor_de_sinal),         // Entrada: parte imediato da instrução
		.out(cabo_extensor_de_sinal_out)  // Saída: 	 imediato estendido para 32 bits
	);
	
	//Declaração da instância da Memória de Dados
	d_mem D_mem (
	.Address(cabo_ALU_out),       // Entrada:  cabo de saída do ALU, contendo o resultado da operacao das duas entradas da ALU
	.WriteData(valor_reg2),       // Entrada:  cabo de saída do read data 2 do regfile
	.ReadData(cabo_d_mem_out),    // Saída:    cabo de saída do d_mem que vai parao o mux_valor_write_data
	.MemWrite(MemWrite),          // Entrada:  cabo da unidade de controle contendo o sinal indicando se deve ou não haver escrita
	.MemRead(MemRead)            // Entrada:  cabo da unidade de controle contendo o sinal indicando se deve ou não haver leitura
	);
	
	//Declaração da instância do Banco de Registradores
	regfile Regfile (
		.ReadAddr1(cabo_rs),                     // Entrada: cabo do rs
		.ReadAddr2(cabo_rt),                     // Saída:   cabo do rt
		.ReadData1(valor_reg1),                  // saída:   cabo de saída do read data 1 do regfile
		.ReadData2(valor_reg2),                  // saída:   cabo de saída do read data 1 do regfile
		.WriteAddr(cabo_mux_dest_reg_regfile),   // Entrada: cabo saída do mux_dest_reg contendo o reg de escrita (rs ou rd)
		.WriteData(cabo_mux_valor_write_data),   // Entrada: cabo saída do mux_valor_write_data contendo o dado para a escrita no regfile 
		.Clock(clock),                           // Entrada: Cabo que contém o clock 
		.Reset(reset_global),                           // Entrada: Cabo que contém o reset 
		.RegWrite(RegWrite)                      // Entrada: Cabo da unidade de controle contendo osinal indicando se deve ou não fazer escrita no rd
	);
	
	//Declaração da instância da Unidade de Controle
	ctrl uc (
		.opcode(cabo_opcode),    // Entrada:  Cabo que contém opcode da instrução 
		.RegDst(RegDst),         // saída: cabo que contém o sinal que indica o reg de escrita
		.Branch(Branch),         // saída: cabo que contém o sinal que indica se deve haver jump
		.MemRead(MemRead),       // saída: cabo que contém o sinal que indica se deve haver leitura
		.MemToReg(MemToReg),     // saída: cabo que contém o sinal que indica se dado vem da memória ou da ALU
		.ALUOp(ALUOp),           // saída: cabo que contém o sinal que indica o tipo de operação a ser realizada pela ALU
		.MemWrite(MemWrite),     // saída: cabo que contém o sinal que indica se deve haver escrita na memória
		.ALUSrc(ALUSrc),         // saída: cabo que contém o sinal que indica qual vai ser o 2° operando da ALU
		.RegWrite(RegWrite),     // saída: cabo que contém o sinal que indica se o dado vai ser escrito no rs ou rd
		.Jump(Jump),             
		.Link(Link)              
    );
	 
	 //Declaração da instância do Unidade Lógica e Aritmética
	 ula ula(
		.in1(cabo_mux_in_1_ALU),                        // Entrada: cabo de saída do read data 1 do reg file
		.in2(cabo_mux_dest_reg_para_regfile),    // Entrada: cabo de saída do 
		.OP(alu_ctrl_out),                       // Entrada:
		.result(cabo_ALU_out),                   // Saída:   cabo de saída contendo o resultado da ALU
		.zero_flag(cabo_zero)                    // Saída:   cabo de saída que contem a flag se result deu 0
	 );   
	 
	 //Declaração da instância do Controle da ULA
	 ula_ctrl ULA_ctrl (
		.ALUOp(ALUOp),               // Entrada: cabo que contém o sinal que indica o tipo de operação a ser realizada pela ALU
		.func(cabo_funct),          // Entrada: cabo que contém o funct
		.ALUCtrl(alu_ctrl_out),    // saida: cabo de saída contendo a operação da ALU
		.Shamt(Shamt)
	 );
	
	//Declaração dos multiplexadores:
	
	//Declaração da instância do mux2x1 que une a saída do somador_pc_4 com a saída do somador_pc_jump para definir qual será o próximo valor do pc
	mux2x1 mux_PC_next (
      .in1(cabo_somador_PC_4_out),  	 // Entrada: Cabo que contém PC + 4
		.in2(cabo_somador_PC_jump_para_mux_PC_next),          // Entrada: Cabo que contem o endereco do pc jump 
		.sel(cabo_and_out),           // Entrada: Cabo que tem o sinal para ocorrer o jump
		.result(cabo_mux_PC_next_para_PC)       // Saída: 	 Cabo que vai para o PC
	);
	
	//Declaração da instância do mux 2x1 que une a saída de Read data 2 com cabo_extensor_de_sinal_out para definir a caminho da ALU 
	mux2x1 mux_in_2_ALU (
		.in1(valor_reg2),  	 		  			// Entrada: Cabo do read data 2
		.in2(cabo_extensor_de_sinal_out),   	// Entrada: Cabo que que contem a saída do extensor de sinal 
		.sel(ALUSrc),           		 		  	// Entrada: Cabo que tem o sinal para definir o 2° operando da ula 
		.result(cabo_mux_dest_reg_para_regfile)   	// Saída:   Cabo que vai para o 2° operando da ula 
	);
	
	//Declaração da instância do mux 2x1 que define se o reg de destino é o rt ou rd
	mux2x1_regdst mux_dest_reg (
		.in1(cabo_rt),  	 		  			  // Entrada: Cabo rs
		.in2(cabo_rd),   						  // Entrada: Cabo rd 
		.sel(RegDst),           		 		  // Entrada: Cabo que tem o sinal para definir o reg de destino
		.result(cabo_mux_dest_reg_regfile)        // Saída:   Cabo que vai para write register em regfile
	);
	
	//Declaração da instância do mux2x1 que diz se o WriteData vem da memória ou da ALU
	mux2x1 mux_valor_write_data (
		.in1(cabo_ALU_out),  	 		  			  	// Entrada: Valor calculado pela ALU
		.in2(cabo_d_mem_out),   						// Entrada: Valor lido da memória 
		.sel(MemToReg),           		 		// Entrada: Cabo que tem o sinal para definir qual o valor a ser usado
		.result(cabo_mux_valor_write_data)        	// Saída:   Cabo que vai para WriteData em regfile
	);	
	//Declaração da intancia do mux2x1 que determina se a primeira entrada da alu vem do readdata1 ou do extensor de sinal
	mux2x1 mux_in_1_ALU(
		.in1(valor_reg1),  	 		  			  	// Entrada: Valor calculado pela ALU
		.in2(cabo_Shamt),   						// Entrada: Valor lido da memória 
		.sel(Shamt),           		 		// Entrada: Cabo que tem o sinal para definir qual o valor a ser usado
		.result(cabo_mux_in_1_ALU) 
	);
	
	// Inicialização das saídas do programa
	assign PC_out = cabo_PC_out;
	assign d_mem_out = cabo_d_mem_out;
	assign ALU_out = cabo_ALU_out;
	assign ula_in1 = cabo_mux_in_1_ALU;
	assign ula_in2 = cabo_mux_dest_reg_para_regfile;
	
	
endmodule
