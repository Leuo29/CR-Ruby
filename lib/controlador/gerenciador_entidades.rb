require_relative '../dominio/nota'
require_relative '../dominio/curso'
require_relative '../dominio/disciplina'
require_relative '../dominio/matricula'

class Gerenciador
  attr_reader :notas

  def initialize(dados_brutos)
    @dados_brutos = dados_brutos
    @repositorio_cursos = {}
    @repositorio_matriculas = {}
    @notas = []
  end

  def processar
    @dados_brutos.each do |linha|
      # 1. pega o curso
      curso = buscar_ou_criar_curso(linha["COD_CURSO"].to_s)
      
      # 2. extrai ano e sem (ex: 20231 -> 2023 e 1)
      ano_semestre = linha["ANO_SEMESTRE"].to_s
      ano = ano_semestre[0..3].to_i
      semestre = ano_semestre[4].to_i
      
      # 3. cria disc nova p cada linha (igual seu python)
      # n usa repo aqui p n cagar o cache de curso
      codigo_disc = linha["COD_DISCIPLINA"]
      carga = linha["CARGA_HORARIA"].to_i
      disciplina = Disciplina.new(codigo_disc, codigo_disc, carga, curso)
      
      # 4. gerencia matricula
      matricula = buscar_ou_criar_matricula(linha["MATRICULA"].to_s, curso)
      
      # 5. cria e vincula nota
      valor = linha["NOTA"].to_f
      nova_nota = Nota.new(valor, disciplina, ano, semestre)
      
      matricula.add_notas(nova_nota)
      @notas << nova_nota
    end

    # 6. calcula cr dps de tudo (igual o python)
    @repositorio_matriculas.values.each(&:calcula_cr)
  end

  def matriculas; @repositorio_matriculas.values; end
  def cursos; @repositorio_cursos.values; end
  def disciplinas
    @notas.map(&:disciplina).uniq
  end

  private

  def buscar_ou_criar_curso(codigo)
    @repositorio_cursos[codigo] ||= Curso.new(codigo)
  end

  def buscar_ou_criar_matricula(id, curso)
    @repositorio_matriculas[id] ||= begin
      m = Matricula.new(id, curso)
      curso.add_matricula(m)
      m
    end
  end
end