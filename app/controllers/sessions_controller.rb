class SessionsController < ApplicationController
  before_action :unsigned, only: [:new, :create]
  before_action :require_login, only: :destroy
  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email], session_params[:password])
      redirect_to root_path, notice: I18n.t('controllers.session.login_s')
    else
      redirect_to :login, notice: I18n.t('controllers.session.login_f')
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: I18n.t('controllers.session.logout')
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
