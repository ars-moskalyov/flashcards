class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def unsigned
    if current_user
      redirect_back(fallback_location: root_path)
    end
  end

  def set_locale
    I18n.locale = session[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
