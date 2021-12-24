class UserMailer < ApplicationMailer
  def form_creation
    @user = params[:user]
    @form = params[:form]
    mail(to: @user.email, subject: "Novo formulário criado: #{@form.title}")
  end

  def form_response
    @form = params[:form]
    @sector = params[:sector]
    mail(to: params[:user].email, subject: "Nova resposta para o formulário: #{@form.title}")
  end
end
