module UserLoginHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out(user)
    forget(user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.renew_remember_token
    cookies.permanent.signed[:user_id] = user.id              # なりすまし防止
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.delete_remember_token
    cookies.delete(:user_id)
    cookies.delete(:remember_token)    
  end
end
