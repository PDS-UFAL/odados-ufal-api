class UserMailer < ApplicationMailer
  def form_creation
    @user = params[:user]
    @form = params[:form]
    mail(to: @user.email, subject: "Um novo formulário foi criado: #{@form.title}")
  end

  def form_response
    @form = params[:form]
    @sector = params[:sector]
    mail(to: params[:user].email, subject: "Uma nova resposta para o formulário: #{@form.title} foi enviada")
  end

  def form_reminder
    @user = params[:user]
    @form = params[:form]
    mail(to: params[:user].email, subject: "O formulário: #{@form.title} expira amanhã")
  end

  def reset_password    
    @url = "#{ENV['FRONTEND_URL']}/redefinir-senha?token=#{params[:user].reset_password_token}"
    mail(to: params[:user].email, subject: 'Pedido de redefinição de senha')
  end
end
