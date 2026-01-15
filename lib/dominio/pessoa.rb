class Pessoa
    attr_reader :nome, :matricula, :data_nasc, :matriculas
    def initialize(nome, matricula, data_nasc)
        @nome = nome
        @data_nasc = data_nasc 
        @matricula = matricula
        @matriculas = []
    end
    def add_matricula(matricula)
        @matriculas << matricula
    end
end