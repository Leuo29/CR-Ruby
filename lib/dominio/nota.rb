class Nota
  attr_reader :valor, :disciplina, :ano, :periodo
  def initialize(valor, disciplina, ano, periodo)
    
    @disciplina = disciplina
    @ano = ano
    @periodo = periodo

    raise ArgumentError, "Nota fora do intervalo" unless valor.between?(0, 10)
    @valor = valor
  end
end