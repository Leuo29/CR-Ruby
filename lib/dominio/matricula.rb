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

        somatorio_carga = @notas.sum { |i| i.disciplina.carga_horaria }
        somatorio_nota_vezes_carga = @notas.sum { |i| i.disciplina.carga_horaria * i.valor}
        
        if (somatorio_carga > 0)
            @cr = (somatorio_nota_vezes_carga.to_f / somatorio_carga).round(2)
        else
            @cr = 0
        end   
    
    end
end