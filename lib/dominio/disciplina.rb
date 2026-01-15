class Disciplina
  attr_reader :codigo, :nome, :carga, :curso
  def initialize(codigo, nome, carga, curso)
    @codigo = codigo
    @nome = nome
    
    @curso = curso

    raise ArgumentError, "Carga zerada ou negativa" unless carga > 0
    @carga = carga 

  end

end