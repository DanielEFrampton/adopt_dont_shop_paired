class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def pet_count
    pets.count
  end

  def no_pending? # needs heavy refactor, ruby doc site is down (~12/8/19 7am)
    pets.all? { |pet| pet.adoptable }
  end
end
