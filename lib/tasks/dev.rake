namespace :dev do

  DEFAULT_PASSOWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
   task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Cadastrando o adminstrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando o adminstradores extras...") { %x(rails dev:add_extras_admin) }
      show_spinner("Cadastrando o usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando algumas questões e respostas...") { %x(rails dev:add_answers_and_questions) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end  

  desc "Adicona o adminstrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: "admin@admin.com",
      password: DEFAULT_PASSOWORD,
      password_confirmation: DEFAULT_PASSOWORD  
    )
  end 
  
  desc "Adicona o adminstrador padrão"
  task add_extras_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSOWORD,
        password_confirmation: DEFAULT_PASSOWORD  
      )
    end
  end

  desc "Adicona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: "user@user.com",
      password: DEFAULT_PASSOWORD,
      password_confirmation: DEFAULT_PASSOWORD  
    )
  end

  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
end

desc "Adiciona questões e respostas"
task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
        rand(5..10).times do |i|
            Question.create!(
            description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
            subject: subject)
        end
    end
end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
  yield
    spinner.success("(#{msg_end})")
  end
end



