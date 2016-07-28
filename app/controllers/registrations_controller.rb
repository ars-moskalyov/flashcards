class RegistrationsController < ApplicationController
  before_action :unsigned

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.locale = I18n.locale
    if @user.save
      login(registration_params[:email], registration_params[:password])
      redirect_to root_path, notice: t('controllers.registration.created')
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email,
                                         :password,
                                         :password_confirmation,
                                         :name,
                                         :subscribe)
  end
end
