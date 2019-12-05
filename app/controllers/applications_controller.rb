class ApplicationsController < ApplicationController
  def new
    @favorited_pets = Pet.find(@favorites.ids)
  end

  def create
    favorites = cookies[:favorites].split(',')

    # possible refactor to helper method
    params[:favorite_ids].each do |favorite_id|
      favorites.delete(favorite_id)
    end

    cookies[:favorites] = favorites.join(',')

    flash[:applied] = "Your application for the selected pets has been submitted."
    redirect_to "/favorites"
  end
end
