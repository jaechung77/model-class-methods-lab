class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # all.limit(5)
    @boats = Boat.limit(5).to_a
  end

  def self.dinghy
    # where("length < 20")
    @boats = Boat.where("length < 20")
  end

  def self.ship
    # where("length >= 20")
    @boats = Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    # all.order(name: :desc).limit(3)
    @boats = Boat.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    # where(captain_id: nil)
    @boats = Boat.where(captain_id: nil)
  end

  def self.sailboats
    # includes(:classifications).where(classifications: { name: 'Sailboat' })
    @boats = Boat.includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    #
    # joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    @boats = Boat.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    # where("id NOT IN (?)", self.sailboats.pluck(:id))
    @boats = Boat.where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    # order('length DESC').first
    @boats = Boat.order('length DESC').first
  end
end
