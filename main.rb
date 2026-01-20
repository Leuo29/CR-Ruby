require_relative 'lib/controlador/controller'

caminho_arquivo = ARGV[0]

if caminho_arquivo.nil?
  print "======================================================\n"
  print "Ola! Seja muito bem vindo a calculadora de CR! ╰(▔∀▔)╯  \n\n"
  print "Digite abaixo o caminho do arquivo CSV: \n"
  caminho_arquivo = gets.chomp
end

# Menu de Seleção de Estratégia
puts "\nQual estratégia de cálculo de CR dos cursos deseja utilizar?"
puts "1 - Por Aluno (Média dos CRs individuais)"
puts "2 - Por Disciplina (Média ponderada global)"
puts "3 - Aluno-Disciplina (CR Global de quem participou)"
print "Escolha (1, 2 ou 3): "
escolha = gets.chomp.to_i

inicio = Process.clock_gettime(Process::CLOCK_MONOTONIC)
app = ControladorSistema.new

puts "\n====================================="
puts "Iniciando processamento de: #{caminho_arquivo} ..."
puts "===================================== \n\n\n"

puts "(つ◕‿◕)つ - aqui esta:  \n\n"

# Passamos a escolha para o executar
app.executar(caminho_arquivo, escolha)

fim = Process.clock_gettime(Process::CLOCK_MONOTONIC)
duracao = fim - inicio

puts "====================================="
puts "Tempo de execução: #{duracao.round(4)} segundos"
puts "====================================="
puts "\nProcessamento finalizado.\n \nObrigado! (▔∀▔)人(▔∀▔)\n\n"