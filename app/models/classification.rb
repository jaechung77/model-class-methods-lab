class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # all
    @classifications = Classification.all
  end

  def self.longest
    # Boat.longest.classifications
    @classifications = Boat.longest.classifications
  end

end
