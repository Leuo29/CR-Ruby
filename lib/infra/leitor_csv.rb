require 'csv'


  class Leitor
    attr_reader :linhas

    def initialize(arquivo_ou_caminho)
      @linhas = []

      CSV.parse(arquivo_ou_caminho, headers: true) do |row|
        @linhas << row.to_h
      end
    end
  end
