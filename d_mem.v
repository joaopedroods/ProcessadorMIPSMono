/*
Arquitetura e Organização de Computadores 2025.1 - Projeto da 2ª VA

Integrantes do grupo:
1. Giovanna Neves
2. João Pedro Oliveira da Silva
3. José Albérico
4. Lucas Lins

Conteúdo do arquivo:
*/

module d_mem(Address, WriteData, ReadData, MemWrite, MemRead);

// Descrição das portas
	input wire [31:0] Address, WriteData;
	input wire MemWrite, MemRead;
	output reg [31:0] ReadData;
	
// Memória parametrizável
	parameter MemSize = 6;
	reg [31:0] mem [0:(1 << MemSize) - 1];
	
	// >>>>>>> PARTE IMPORTANTE SOBRE O ENDEREÇO <<<<<<<<
   // A memória foi declarada como palavras de 32 bits (4 bytes cada).
   // Porém, o sinal Address vem em bytes (por exemplo, 0x00, 0x04, 0x08...).
   // Para acessar corretamente a posição do vetor mem, é preciso "ignorar" os dois últimos bits do Address.
   // Isso equivale a dividir o endereço por 4, ou seja, fazer um deslocamento para a direita de 2 bits:
   wire [31:0] aligned_address = Address >> 2;
	
	always @(*) begin
		// Verificação de acesso fora dos limites da memória (proteção)
		if (aligned_address >= (1 << MemSize)) begin
			$display("Endereço %d fora do limite!", Address);
				ReadData = 32'b0;
		end else begin
			// Se MemRead = 1, realiza a leitura da memória no endereço alinhado
			if (MemRead) 
				ReadData = mem[aligned_address];
			else
            // Caso não esteja lendo, a saída é colocada em alta impedância ('z')
            // Isso simula o comportamento de um barramento em repouso
            ReadData = 32'bz;

          // Se MemWrite = 1, escreve o dado na posição correspondente da memória
          if (MemWrite)
				mem[aligned_address] = WriteData;
		end
	end	
endmodule
