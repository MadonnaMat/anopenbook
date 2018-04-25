# frozen_string_literal: true

class Book < ApplicationRecord
  extend FriendlyId
  include CurrentStep

  enum genre: %i[romance crime science_fiction fantasy horror]

  friendly_id :slug_canidates, use: :history

  has_and_belongs_to_many :users
  has_one_attached :cover
  has_many :submissions, dependent: :destroy

  before_save :ensure_cover

  default_scope do
    order("current_step = #{Book.current_steps[:complete]}")
      .order(read_count: :desc)
  end

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

  def show_path
    Rails.application.routes.url_helpers.polymorphic_url(self, only_path: true)
  end

  def cover_path
    if cover.attached?
      Rails.application.routes.url_helpers.polymorphic_url(cover.variant(resize: '102x156'), only_path: true)
    end
  end

  def as_json(_args)
    super(methods: %i[cover_path show_path])
  end

  private

  def ensure_cover
    return if cover.attached?
    require 'securerandom'

    img_loc = Tempfile.new(['cover', '.png'])

    MiniMagick::Tool::Convert.new do |i|
      i.size '510x780'
      i << 'xc:white'
      i.gravity 'North'
      i.geometry '+200 +100'
      i.pointsize '36'
      i.caption "\\n#{title}"
      i.composite img_loc.path
    end

    img_loc.rewind

    cover.attach(io: img_loc,
                 filename: "#{title.parameterize.underscore}.png",
                 content_type: 'image/png')

    img_loc.close
    img_loc.unlink
  end
end
