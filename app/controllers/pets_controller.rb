class PetsController < ApplicationController
  def index
    if params[:adoptable] == "true"
      @pets = Pet.where(adoptable: params[:adoptable])
      @adoptable_pets = "active_sort"
    elsif params[:adoptable] == "false"
      @pets = Pet.where(adoptable: params[:adoptable])
      @pending_pets = "active_sort"
    else
      @pets = Pet.order(adoptable: :desc)
      @all_pets = "active_sort"
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create(pet_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:incomplete] = "You attempted to submit the form without completing required field(s): #{empty_params(pet_params)}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if pet.save
      redirect_to "/pets/#{pet.id}"
    else
      flash[:incomplete] = "You attempted to submit the form without completing required field(s): #{empty_params(pet_params)}"
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    @favorites.delete(params[:id])
    session[:favorites] = @favorites.favorited_pets

    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def update_status
    pet = Pet.find(params[:pet_id])
    pet.update({
                adoptable: params[:new_status] == "adoptable" ? true : false
              })
    pet.save
    if params[:new_status] == "pending"
      pet_application = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id]).first
      pet_application.update(approved: true)
      pet_application.save
      redirect_to "/pets/#{params[:pet_id]}"
    else
      pet_application = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id]).first
      pet_application.update(approved: false)
      pet_application.save
      redirect_to "/applications/#{params[:application_id]}"
    end
  end

  private

  def pet_params
    params.permit(:name, :approx_age, :sex, :image_path, :description)
  end
end
