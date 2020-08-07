class UserLoginController < ApplicationController
  def login
    @no_header = true
  end

  def auth
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      sign_in(user)
      if auth_params[:remember] == "1"
        remember(user)
      else
        forget(user)    
      end
      redirect_to root_url, notice: "login success!"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :login
    end
  end

  def logout
    sign_out(current_user)
    redirect_to root_url, notice: "sign out successful!"
  end

  def auth_params
    params.permit(:email, :password, :remember)
  end
end
