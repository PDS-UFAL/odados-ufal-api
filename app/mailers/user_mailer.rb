class UserMailer < ApplicationMailer
  def user_creation
    @user = params[:user]
    @url = "#{ENV['FRONTEND_URL']}/forgot-password"
    mail(to: @user.email, subject: "O seu usuário foi criado no sistema Observatório de Dados UFAL")
  end

  def form_creation
    @user = params[:user]
    @form = params[:form]
    mail(to: @user.email, subject: "Um novo formulário foi criado: #{@form.subtitle}")
  end

  def form_response
    @form = params[:form]
    @sector = params[:sector]
    mail(to: params[:user].email, subject: "Uma nova resposta para o formulário: #{@form.subtitle} foi enviada")
  end

  def form_reminder
    @user = params[:user]
    @form = params[:form]
    mail(to: params[:user].email, subject: "O formulário: #{@form.subtitle} expira hoje")
  end

  def reset_password    
    @url = "#{ENV['FRONTEND_URL']}/redefinir-senha?token=#{params[:user].reset_password_token}"
    mail(to: params[:user].email, subject: 'Pedido de redefinição de senha')
  end
end
