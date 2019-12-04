class FavoritesController < ApplicationController
  def index
    @favorites = Pet.find(cookies[:favorites].split(','))
  end

  def create
    cookies[:favorites] += "#{!cookies[:favorites].empty? ? ', ' : ''}#{params[:id]}"
    flash[:favorited] = "This pet has been added to your favorites!"
    redirect_to "/pets/#{params[:id]}"
  end
end
