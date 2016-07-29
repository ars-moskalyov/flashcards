class SessionsController < ApplicationController
  before_action :unsigned, only: [:new, :create]
  before_action :require_login, only: :destroy

  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email], session_params[:password])
      redirect_to root_path, notice: t('.login_s')
    else
      redirect_to :login, notice: t('.login_f')
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('.logout')
  end

  def locale
    if current_user
      current_user.update!(locale: params[:locale])
    else
      session[:locale] = params[:locale]
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def session_params
    params.require(:session).permit(:email,
                                    :password)
  end
end
