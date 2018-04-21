class Submission < ApplicationRecord
  extend FriendlyId
  include CurrentStep

  friendly_id :slug_canidates, use: :history

  acts_as_votable
  has_paper_trail only: [:body]

  belongs_to :user
  belongs_to :book
  belongs_to :parent, class_name: 'Submission', required: false

  def slug_canidates
    [
      :title,
      %i[title current_step]
    ]
  end
end
