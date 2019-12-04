class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup_favorites

  private

    def setup_favorites
      cookies[:favorites] ||= ""
      @num_favorites = cookies[:favorites].split(',').length
    end
end
