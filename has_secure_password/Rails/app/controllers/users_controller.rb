# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(edit)

  def new
    @no_header = true
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return render :new unless @user.valid?

    if @user.save
      sign_in(@user)
      redirect_to complete_users_url
    else
      render :new
    end
  end

  def complete
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    return render :edit if @user.nil?

    if @user.update_attributes(user_params)
      sign_in(@user)
      redirect_to complete_users_url
    else
      render :new
    end
  end

  def quit
  end

  def quit_complete
    sign_out(current_user)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
