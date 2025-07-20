/*
Arquitetura e Organização de Computadores 2025.1 - Projeto da 2ª VA

Integrantes do grupo:
1. Giovanna Neves
2. João Pedro Oliveira da Silva
3. José Albérico
4. Lucas Lins

Conteúdo do arquivo:
*/

module ula_ctrl(ALUOp, func, ALUCtrl);
    // Descrição das portas
    input  wire [3:0] ALUOp;      // Código da operação da ULA (derivado do opcode da instrução)
    input  wire [5:0] func;		// Campo funct para instruções do tipo R
    output reg  [3:0] ALUCtrl; 	// Código da operação que será executada na ULA

    // Bloco combinacional: Define o controle da ULA com base na operação
    always @(*) begin
        case(ALUOp)
            4'b1111: begin // Instruções do tipo R
                case(func)
                    6'b000000: ALUCtrl = 4'b1001; // SLL (Shift Left Logical)
                    6'b000010: ALUCtrl = 4'b1010; // SRL (Shift Right Logical)
                    6'b000011: ALUCtrl = 4'b1101; // SRA (Shift Right Arithmetic)
                    6'b000100: ALUCtrl = 4'b0011; // SLLV (Shift Left Logical Variable)
                    6'b000110: ALUCtrl = 4'b0100; // SRLV (Shift Right Logical Variable)
                    6'b000111: ALUCtrl = 4'b0101; // SRAV (Shift Right Arithmetic Variable)
                    6'b100000: ALUCtrl = 4'b0010; // ADD
                    6'b100010: ALUCtrl = 4'b0110; // SUB
                    6'b100100: ALUCtrl = 4'b0000; // AND
                    6'b100101: ALUCtrl = 4'b0001; // OR
                    6'b100110: ALUCtrl = 4'b1011; // XOR
                    6'b100111: ALUCtrl = 4'b1100; // NOR
                    6'b101010: ALUCtrl = 4'b0111; // SLT
                    6'b101011: ALUCtrl = 4'b1111; // SLTU
                    default:   ALUCtrl = 4'bxxxx; // Operação indefinida
                endcase
            end
            4'b0100: ALUCtrl = 4'b0110; // BEQ (Subtração para comparação)
            4'b0101: ALUCtrl = 4'b1000; // BNE (Tratamento especial)
            4'b1000: ALUCtrl = 4'b0010; // ADDI (Soma imediata)
            4'b1010: ALUCtrl = 4'b0111; // SLTI (Set Less Than Immediate)
            4'b1011: ALUCtrl = 4'b1111; // SLTIU (Set Less Than Immediate Unsigned)
            4'b1100: ALUCtrl = 4'b0000; // ANDI (AND imediato)
            4'b1101: ALUCtrl = 4'b0001; // ORI (OR imediato)
            4'b1110: ALUCtrl = 4'b1011; // XORI (XOR imediato)
            default: ALUCtrl = 4'b0010; // Operação padrão (lw/sw fazem soma)
        endcase
    end
endmodule
