/*
Arquitetura e Organização de Computadores 2025.1 - Projeto da 2ª VA

Integrantes do grupo:
1. Giovanna Neves
2. João Pedro Oliveira da Silva
3. José Albérico
4. Lucas Lins

Conteúdo do arquivo:
*/

module i_mem(address, i_out);

// Parâmetro do tamanho da memória
	parameter TAMANHO_MEMORIA = 64;

// Descrição das entradas e saídas:
	input wire [31:0] address;
	output wire [31:0] i_out;
	
// Declaração da memória ROM
	reg [31:0] memoria_ROM [0:TAMANHO_MEMORIA - 1];
	
// Inicialização da memória com a leitura do arquivo instruction.list
/*
O bloco "initial begin ... end" é executado uma única vez no início da simulação. Dentro dele temos o $readmemb, que é uma função do Verilog
para ler arquivos com binários. Esses dados vão preencher o vetor memoria_ROM
*/
	initial begin
		$readmemb("instruction.list", memoria_ROM);
	end
	
// Leitura assíncrona da memória ROM, indexando por address dividido por 4
	assign i_out = memoria_ROM[address >> 2];

endmodule
