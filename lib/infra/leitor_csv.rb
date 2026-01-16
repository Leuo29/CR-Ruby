require 'csv'

class Leitor
  attr_reader :linhas

  def initialize(caminho_do_arquivo)
    @linhas = []

    
    CSV.foreach(caminho_do_arquivo, headers: true) do |row|
      @linhas << row.to_h
    end
  rescue Errno::ENOENT
    raise "Erro: O arquivo '#{caminho_do_arquivo}' não foi encontrado."
  end
end