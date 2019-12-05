class ApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(cookies[:favorites].split(','))
  end

  def create
    new_application = Application.new(application_params)
    if new_application.save
      favorites = cookies[:favorites].split(',')

      # possible refactor to helper method
      params[:favorite_ids].each do |favorite_id|
        favorites.delete(favorite_id)
      end

      cookies[:favorites] = favorites.join(',')

      flash[:applied] = "Your application for the selected pets has been submitted."
      redirect_to "/favorites"
    else
      flash.now[:incomplete] = "You must complete all fields in order to submit the application."
      render :new
    end
  end
end
