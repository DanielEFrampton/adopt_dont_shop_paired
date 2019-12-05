class FavoritesList
  attr_reader :ids

  # anticipating that favorited_pets comes in as a hash from the session;
  # i.e., session[:favorited_pets] = {"341" => true; "457" => true}
  def initialize(favorited_pets)
    @favorited_pets = favorited_pets
  end

  def total_favorites
    @ids.length
  end
end
