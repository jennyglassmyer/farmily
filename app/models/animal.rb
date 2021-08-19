class Animal < ApplicationRecord
  has_many_attached :photos
  has_many :bookings
  belongs_to :user
  validates :species, inclusion: { in: ["Horse", "Cow", "Pig", "Dog", "Chicken", "Cat", "Goat", "Sheep", "Duck", "Goose"] }
  validates :name, presence: true
  validates :species, presence: true
  validates :gender, presence: true
  validates :personality, presence: true
  validates :description, presence: true
  validates :care_level, presence: true
  validates :age, presence: true
  validates :price_per_day, presence: true
  validates :care_instructions, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_species_and_name,
    against: [ :species, :name ],
    using: {
      tsearch: { prefix: true }
    }
  # multisearchable against: [:species, :name]
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
