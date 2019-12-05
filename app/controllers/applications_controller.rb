class ApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(cookies[:favorites].split(','))
  end

  def create
    return nothing_checked if !params.has_key?(:favorite_ids)
    new_application = Application.new(application_params)
    if new_application.save
      # params[:favorite_ids].each do |favorite_id|
      #   PetApplication.create({pet_id: favorite_id, application_id: new_application})
      # end

      # possible refactor to helper method
      favorites = cookies[:favorites].split(',')
      params[:favorite_ids].each do |favorite_id|
        favorites.delete(favorite_id)
      end
      cookies[:favorites] = favorites.join(',')

      flash[:applied] = "Your application for the selected pets has been submitted."
      redirect_to "/favorites"
    else
      flash[:incomplete] = "You must complete all fields in order to submit the application."
      redirect_to '/applications/new'
    end
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end

    def nothing_checked
      flash[:nothing_checked] = "You must select at least one favorited pet by checking its box."
      redirect_to '/applications/new'
    end
end
