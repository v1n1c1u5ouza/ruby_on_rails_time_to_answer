namespace :dev do

  DEFAULT_PASSOWORD = 123456

  desc "Configura o ambiente de desenvolvimento"
   task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Cadastrando o adminstrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando o adminstradores extras...") { %x(rails dev:add_extras_admin) }
      show_spinner("Cadastrando o usuário padrão...") { %x(rails dev:add_default_user) }
      
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

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
  yield
    spinner.success("(#{msg_end})")
  end
end



