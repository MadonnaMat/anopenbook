class Book < ApplicationRecord
  extend FriendlyId
  enum genre: %i[romance crime science_fiction fantasy horror]

  friendly_id :slug_canidates, use: :slugged

  has_and_belongs_to_many :books
  has_one_attached :cover

  def slug_canidates
    [
      :title,
      %i[title genre]
    ]
  end
end
