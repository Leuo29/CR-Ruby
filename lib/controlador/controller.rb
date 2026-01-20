require_relative 'gerenciador_entidades'
require_relative '../infra/leitor_csv' 
require_relative 'relatorio'
require_relative '../dominio/strategies/curso_cr_strategy'
require_relative '../dominio/strategies/cr_por_aluno'
require_relative '../dominio/strategies/cr_por_disciplina'
require_relative '../dominio/strategies/cr_aluno_disciplina'

class ControladorSistema
  def executar(caminho_arquivo, opcao_estrategia = 1)

    # chama o leitor abre o csv que retorna um hash 
    leitor = Leitor.new(caminho_arquivo)
    dados_brutos = leitor.linhas

    # cria os objetos
    gerenciador = Gerenciador.new(dados_brutos)
    gerenciador.processar

    # escolhe a estrategia de media de cr de curso baseado no q o user digitou
    estrategia = case opcao_estrategia
                 when 1 then CursoCRPorAluno.new
                 when 2 then CursoCRPorDisciplina.new
                 when 3 then CursoCRAlunoDisciplina.new
                 else CursoCRPorAluno.new # se der ruim, vai no 1 msm
                 end
    # imprime 
    relatorio = Relatorio.new(gerenciador.matriculas, gerenciador.cursos)
    relatorio.imprimir(estrategia)
    
  rescue StandardError => e
    puts "Erro na execução do sistema: #{e.message}"
  end
end