class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def unsigned
    if current_user
      request.env["HTTP_REFERER"] ||= root_path 
      redirect_to :back, notice: t('controllers.application.unsigned')
    end
  end
end
