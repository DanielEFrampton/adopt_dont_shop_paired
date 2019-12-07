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
    pet = shelter.pets.create({
                                name:         params[:name],
                                approx_age:   params[:approx_age],
                                sex:          params[:sex],
                                image_path:   params[:image_path],
                                description:  params[:description]
                              })
    pet.save
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
                name:         params[:name],
                approx_age:   params[:approx_age],
                sex:          params[:sex],
                image_path:   params[:image_path],
                description:  params[:description]
              })
    pet.save

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def update_status
    pet = Pet.find(params[:pet_id])
    pet.update({
                adoptable: params[:new_status] == "adoptable" ? true : false
              })
    pet.save
    pet_application = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id]).first
    pet_application.update(approved: true)
    pet_application.save
    redirect_to "/pets/#{pet.id}"
  end
end
