class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup_favorites
  helper_method :empty_params

  def empty_params(strong_params)
    strong_params.to_h.reduce("") do |empty_params,(key, value)|
      next empty_params if value != ""
      empty_params.empty? ? empty_params += key.capitalize : empty_params += ', ' + key.capitalize
    end
  end
  
  private

    def setup_favorites
      @favorites = FavoritesList.new(session[:favorites])
    end
end
