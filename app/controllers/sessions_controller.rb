class SessionsController < ApplicationController
  def new
  end

  def create
  admin = Admin.find_by(email: session_params[:email])
  if admin&.valid_password?(session_params[:password])
  reset_session
  session[:admin_id] = admin.id
  redirect_to admin_area_dogs_path, notice: "Login realizado com sucesso como administrador!"
  else
  flash.now[:alert] = "Email ou senha inválidos"
  render :new, status: :unprocessable_entity
  end
  end

  def destroy
  reset_session
  redirect_to login_path, notice: "Logout realizado com sucesso!"
  end

  private

  def session_params
  params.permit(:email, :password)
  end
end
