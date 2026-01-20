require 'csv'

class Leitor
  attr_reader :linhas

  def initialize(caminho_do_arquivo)
    
    @linhas = []

    # varre o csv linha por linha
    CSV.foreach(caminho_do_arquivo, headers: true) do |row|
      # converte cada linha p hash e joga no array
      @linhas << row.to_h
    end
  rescue Errno::ENOENT
    raise "Erro: O arquivo '#{caminho_do_arquivo}' não foi encontrado."
  end
end