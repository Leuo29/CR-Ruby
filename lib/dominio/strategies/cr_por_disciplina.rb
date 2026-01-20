require_relative 'curso_cr_strategy'

class CursoCRPorDisciplina < CursoCRStrategy
  def calcular(curso, todas_as_matriculas, ano = nil, semestre = nil)
    soma_nota_carga = 0.0
    soma_carga = 0.0

    
    todas_as_matriculas.each do |m|
      
      m.notas.each do |nota|
        # so entra na conta se a materia for desse curso
        if nota.disciplina.curso && nota.disciplina.curso.nome == curso.nome
          
          soma_nota_carga += (nota.valor.to_f * nota.disciplina.carga_horaria.to_f)
          soma_carga += nota.disciplina.carga_horaria.to_f
        end
      end
    end

    
    soma_carga > 0 ? (soma_nota_carga / soma_carga) : 0.0
  end
end