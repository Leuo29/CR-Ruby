require_relative 'curso_cr_strategy'

class CursoCRAlunoDisciplina < CursoCRStrategy
  def calcular(curso, todas_as_matriculas)
    
    alunos_contados = [] # lista p n contar o msm aluno duas vezes
    soma_cr_global = 0.0

    
    todas_as_matriculas.each do |m|
      # se o aluno ja foi somado pula
      next if alunos_contados.include?(m.codigo)
      participou = m.notas.any? { |n| n.disciplina.curso == curso }
      # se participou e tem cr soma o cr dele
      if participou && m.cr > 0
        soma_cr_global += m.cr
        alunos_contados << m.codigo
      end
    end
    alunos_contados.empty? ? 0.0 : (soma_cr_global / alunos_contados.size)
  end
end