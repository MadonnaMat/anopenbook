# frozen_string_literal: true

class Submission < ApplicationRecord
  extend FriendlyId
  include CurrentStep

  friendly_id :slug_canidates, use: :history

  acts_as_votable
  has_paper_trail only: [:body]

  belongs_to :user
  belongs_to :book
  belongs_to :parent, class_name: 'Submission', required: false
  before_save :sanitize_body

  scope :synopses, -> { where(type: 'Synopsis') }
  scope :includeds, -> { where(is_included: true) }

  def self.descendants
    [Synopsis, CoverArt, Chapter, Title]
  end

  def slug_canidates
    [
      :title,
      %i[title current_step]
    ]
  end

  private

  def sanitize_body
    self.body = sanitize_with_css(body || '')
  end
end
