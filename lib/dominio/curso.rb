require_relative 'strategies/curso_cr_strategy'
require_relative 'strategies/cr_por_aluno'
require_relative 'strategies/cr_por_disciplina'
require_relative 'strategies/cr_aluno_disciplina'

class Curso
  attr_reader :codigo, :matriculas, :nome
  attr_accessor :strategy

  def initialize(codigo)
    @codigo = codigo
    @nome = codigo
    @matriculas = [] # lista p guardar os alunos desse curso
    @strategy = CursoCRPorAluno.new 
  end

  def calcula_media_cr(todas_as_matriculas = [])
    @strategy.calcular(self, todas_as_matriculas)
  end
  
  def add_matricula(m); @matriculas << m; end
end