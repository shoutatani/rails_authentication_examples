class ApplicationController < ActionController::Base
  include UserLoginHelper

  private

  def current_user
    if user_id = session[:user_id]
      # セッションが存在 => ログイン中
      @current_user ||= User.find(user_id)
    elsif user_id = cookies.signed[:user_id]
      # => セッションはないが、署名済み(暗号化)user_idがあるということは、先のログイン時の記憶オプションがON
      user = User.find(user_id)
      return unless user && user.has_authenticated_token?(cookies[:remember_token])
      sign_in(user)
      @current_user = user
    end
  end

  def user_signed_in?
    !!current_user
  end
  
  def authenticate_user!
    redirect_to root_url unless user_signed_in?
  end

  helper_method :current_user, :user_signed_in?
end
