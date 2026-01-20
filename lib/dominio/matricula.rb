class Matricula
    attr_reader :codigo, :curso, :notas, :cr 
    def initialize(codigo,curso)
        @codigo = codigo
        @curso = curso
        @notas = []
        @cr = 0.0
    end

    def add_notas(nota)
        @notas << nota
    end
    
    def calcula_cr()
        somatorio_carga = 0
        somatorio_nota_vezes_carga = 0

        # soma todas as cargas 
        somatorio_carga = @notas.sum { |i| i.disciplina.carga_horaria }
        
        #soma nota x carga
        somatorio_nota_vezes_carga = @notas.sum { |i| i.disciplina.carga_horaria * i.valor}
        
        #evita divisao por 0
        if (somatorio_carga > 0)
            @cr = (somatorio_nota_vezes_carga.to_f / somatorio_carga).round(2)
        else
            @cr = 0
        end   
    end
end