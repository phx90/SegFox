class SessionsController < ApplicationController
  before_action :redirect_authenticated_admin, only: :new

  def new
  end

  def create
    admin = Admin.find_by(email: session_params[:email].to_s.strip.downcase)

    unless admin&.valid_password?(session_params[:password])
      flash.now[:alert] = "E-mail ou senha inválidos."
      return render :new, status: :unprocessable_content
    end

    return_to = session.delete(:return_to)
    reset_session
    session[:admin_id] = admin.id
    redirect_to(return_to.presence || admin_area_dogs_path, notice: "Login realizado com sucesso.")
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logout realizado com sucesso."
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def redirect_authenticated_admin
    redirect_to admin_area_dogs_path if admin_signed_in?
  end
end
