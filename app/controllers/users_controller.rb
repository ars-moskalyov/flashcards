class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to root_path, notice: I18n.t('controllers.user.updated')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
