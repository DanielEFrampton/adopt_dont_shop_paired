class FavoritesList
  attr_reader :favorited_pets

  # anticipating that favorited_pets comes in as a hash from the session;
  # i.e., session[:favorited_pets] = {"341" => true; "457" => true}
  def initialize(favorited_pets)
    @favorited_pets = favorited_pets ||= Hash.new
  end

  def ids
    @favorited_pets.keys
  end

  def total_favorites
    @favorited_pets.keys.length
  end
end
