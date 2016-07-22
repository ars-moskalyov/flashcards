class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def unsigned
    if current_user
      redirect_back(fallback_location: root_path)
    end
  end
end
