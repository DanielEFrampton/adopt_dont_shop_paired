class SheltersController < ApplicationController
  def index
    if params[:sort_by] == "adoptable"
      @shelters = Shelter.by_most_adoptable
      @adoptable_order = "active_sort"
    elsif params[:sort_by] == "alphabet"
      @shelters = Shelter.order(:name)
      @alphabet_order = "active_sort"
    else
      @shelters = Shelter.all
      @created_order = "active_sort"
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:incomplete] = "You attempted to submit the form without completing required field(s): #{empty_params(shelter_params)}"
      redirect_to '/shelters/new'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  def pets
    @shelter = Shelter.find(params[:id])
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
