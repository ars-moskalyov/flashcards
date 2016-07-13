class RegistrationsController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(registration_params)
    if @new_user.save
      login(registration_params[:email], registration_params[:password])
      redirect_to root_path, notice: I18n.t('controllers.registration.created')
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
