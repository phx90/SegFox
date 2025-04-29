class ApplicationController < ActionController::Base
  # Só permite browsers modernos
  allow_browser versions: :modern

  helper_method :admin_signed_in?, :current_admin

  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  def admin_signed_in?
    current_admin.present?
  end

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to login_path, alert: "Você precisa estar logado para acessar esta área."
    end
  end
end
