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
Arquivo:      i_mem.v
Módulo:       i_mem

Descrição:
              Implementa a Memória de Instrução (ROM) do processador. O módulo
              é inicializado no início da simulação com os dados do arquivo
              'instruction.list'. A leitura é assíncrona, e o endereço de
              entrada (em bytes) é convertido para um índice de palavra
              (dividido por 4) para acessar a memória.
================================================================================
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
