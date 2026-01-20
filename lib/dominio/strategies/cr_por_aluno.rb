require_relative 'curso_cr_strategy'
class CursoCRPorAluno < CursoCRStrategy
  def calcular(curso, _todas_as_matriculas)
    return 0.0 if curso.matriculas.empty?
    
    total_cr = curso.matriculas.sum { |m| m.cr }
    total_cr.to_f / curso.matriculas.size
  end
end