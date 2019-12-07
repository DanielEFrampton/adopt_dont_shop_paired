class ApplicationsController < ApplicationController
  def new
    @favorited_pets = Pet.find(@favorites.ids)
  end

  def create
    @favorites.delete(params[:favorite_ids])
    session[:favorites] = @favorites.favorited_pets

    flash[:applied] = "Your application for the selected pets has been submitted."
    redirect_to "/favorites"
  end
end
