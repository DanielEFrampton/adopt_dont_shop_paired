class Pet < ApplicationRecord
  validates_presence_of :name, :sex, :approx_age, :image_path, :description
  validates_inclusion_of :adoptable, :in => [true, false]
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def adoptable_status
    adoptable ? "adoptable" : "pending"
  end

  def owner
    Application.joins(:pets).where("pet_applications.approved=true AND pets.id=#{id}").first
  end
end
