class FavoritesList
  attr_reader :ids

  def initialize(pet_ids)
    @ids = pet_ids.split(',') || []
  end

  def total_favorites
    @ids.length
  end
end
