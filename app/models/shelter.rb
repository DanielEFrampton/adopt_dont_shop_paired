class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def no_pending?
    pets.where(adoptable: false).none?
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    pets.joins(:applications)
        .select(:application_id)
        .distinct.count
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

  def sort_pets(requested_order)
    if requested_order == 'true'
      pets.where(adoptable: true)
    elsif requested_order == 'false'
      pets.where(adoptable: false)
    else
      pets.order(adoptable: :desc)
    end
  end
end
