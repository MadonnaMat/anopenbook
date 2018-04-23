# frozen_string_literal: true

class Book < ApplicationRecord
  extend FriendlyId
  include CurrentStep

  enum genre: %i[romance crime science_fiction fantasy horror]

  friendly_id :slug_canidates, use: :history

  has_and_belongs_to_many :users
  has_one_attached :cover
  has_many :submissions, dependent: :destroy

  scope :manuscripts,
        lambda {
          where.not(current_step: Book.current_steps[:complete])
               .where('current_step_ends_at > ?', Time.now)
        }

  scope :completes, -> {
                      where(current_step:
                               Book.current_steps[:complete])
                    }

  def slug_canidates
    [
      :title,
      %i[title genre]
    ]
    end
end
