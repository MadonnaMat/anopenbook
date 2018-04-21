class Book < ApplicationRecord
  extend FriendlyId
  include CurrentStep

  enum genre: %i[romance crime science_fiction fantasy horror]

  friendly_id :slug_canidates, use: :history

  has_and_belongs_to_many :users
  has_one_attached :cover
  has_many :submissons

  def slug_canidates
    [
      :title,
      %i[title genre]
    ]
  end
end
