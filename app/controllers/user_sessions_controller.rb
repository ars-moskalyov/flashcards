class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(user_session_params[:email], user_session_params[:password])
      redirect_to root_path, notice: I18n.t('controllers.user_session.login_s')
    else
      redirect_to :login, notice: I18n.t('controllers.user_session.login_f')
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: I18n.t('controllers.user_session.logout')
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
