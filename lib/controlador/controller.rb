require_relative 'gerenciador_entidades'
require_relative '../infra/leitor_csv' 
require_relative 'relatorio'

class ControladorSistema
  def executar(caminho_arquivo)

    leitor = Leitor.new(caminho_arquivo)
    dados_brutos = leitor.linhas


    gerenciador = Gerenciador.new(dados_brutos)
    gerenciador.processar


    matriculas = gerenciador.matriculas
    cursos = gerenciador.cursos


    relatorio = Relatorio.new(matriculas, cursos)
    relatorio.imprimir
    
  rescue StandardError => e
    puts "Erro na execução do sistema: #{e.message}"
  end
end