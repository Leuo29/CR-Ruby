class Disciplina
  attr_reader :codigo, :nome, :carga_horaria, :curso
  def initialize(codigo, nome, carga, curso)
    @codigo = codigo
    @nome = codigo
    @curso = curso
    raise ArgumentError, "Carga zerada ou negativa" unless carga > 0
    @carga_horaria = carga 

  end

end