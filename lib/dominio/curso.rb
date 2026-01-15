class Curso
    attr_reader :codigo, :nome, :matriculas
    def initialize(codigo)
        @codigo = codigo 
        @nome = codigo    
        @matriculas = [] 
    end

    def calcula_media_cr()
        
        if @matriculas.size > 0
            @matriculas.sum { |i| i.cr }.to_f / @matriculas.size
        else 
            0.0
        end    
    end

    def add_matricula(matricula)
      @matriculas << matricula
    end
end