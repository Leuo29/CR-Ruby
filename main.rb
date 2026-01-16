

require_relative 'lib/controlador/controller'


caminho_arquivo = ARGV[0]

if caminho_arquivo.nil?
  print "======================================================\n"
  print "Ola! Seja muito bem vindo a calculadora de CR! ╰(▔∀▔)╯  \n\n"
  print "Digite ao abaixo caminho do arquivo CSV com os dados necessarios: \n"
  caminho_arquivo = gets.chomp
  
end

app = ControladorSistema.new

puts "\n====================================="
puts "Iniciando processamento de: #{caminho_arquivo} ..."
puts "===================================== \n\n\n"

puts "(つ◕‿◕)つ - aqui esta:  \n\n"

app.executar(caminho_arquivo)




puts "\nProcessamento finalizado.\n \nObrigado! (▔∀▔)人(▔∀▔)\n\n"