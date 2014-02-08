class ApplicationController < ActionController::Base
  protect_from_forgery

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'You need to be signed in!' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to signin_path, notice:'You need to sign in with an admin account to do that!' unless current_user.admin?
  end
end
