class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def no_pending? # needs heavy refactor, ruby doc site is down (~12/8/19 7am)
    pets.all? { |pet| pet.adoptable }
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    Shelter.where(id: id).joins(pets: :applications).distinct.count
  end

  def self.top_rated
    select('shelters.name, shelters.id, AVG(reviews.rating) AS average_rating')
    .joins(:reviews)
    .order('average_rating DESC')
    .limit(3)
    .group('shelters.id')
  end

  def self.by_most_adoptable
    joins(:pets)
    .order('count(CASE pets.adoptable WHEN true THEN 1 ELSE null END) DESC')
    .group('shelters.id')
  end
  
  def sort_reviews(requested_order)
    if requested_order == 'highest'
      reviews.order('rating DESC, created_at DESC')
    elsif requested_order == 'lowest'
      reviews.order('rating, created_at')
    else
      reviews
    end
  end
end
