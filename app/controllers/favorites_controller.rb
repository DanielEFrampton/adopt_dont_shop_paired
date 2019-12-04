class FavoritesController < ApplicationController
  def create
    cookies[:favorites] += "#{!cookies[:favorites].empty? ? ', ' : ''}params[:id]"
    flash[:favorited] = "This pet has been added to your favorites!"
    redirect_to "/pets/#{params[:id]}"
  end
end
