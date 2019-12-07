class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup_favorites

  private

    def setup_favorites
      @favorites = FavoritesList.new(cookies[:favorites])
    end
end
