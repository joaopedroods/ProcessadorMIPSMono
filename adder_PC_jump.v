module adder_PC_jump (endereco_PC, endereco_deslocado, endereco_jump);

	// Descrição das entradas e saídas:
   input wire [31:0] endereco_PC;          // Valor atual do PC
   input wire [31:0] endereco_deslocado; 	 // Endereço deslocado (após o Shift Left 2)
   output wire [31:0] endereco_jump;       // Endereço final do Jump (Saída) 

   // Comportamento:
   assign endereco_jump = endereco_PC + endereco_deslocado;  // soma os endereco do pc e o endereco deslocado e retorna em endereco_jump	
endmodule