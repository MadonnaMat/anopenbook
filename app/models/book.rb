# frozen_string_literal: true

class Book < ApplicationRecord
  extend FriendlyId
  include CurrentStep
  include Rails.application.routes.url_helpers

  enum genre: %i[romance crime science_fiction fantasy horror]

  friendly_id :slug_canidates, use: :history
  validates_presence_of :title
  validates_presence_of :genre
  validates_presence_of :current_step

  has_and_belongs_to_many :users
  has_one_attached :cover
  has_many :submissions, dependent: :destroy

  before_save :ensure_cover

  default_scope do
    ordering { current_step == Book.current_steps[:complete] }
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

  def synopses
    submissions.synopses
  end

  def included_synopses
    synopses.includeds.first
  end

  def previous_step_winner
    false
  end

  def is_manuscript?
    current_step != :complete
  end

  def transition_and_translation
    type, step, chapter = type_step_chapter

    in_type = type == 'chapter' ? I18n.t('book.submission.chapter', ch: chapter) : I18n.t("book.submission.#{type}")
    if step == 'submission'
      [I18n.t('book.submission_step', type: in_type), url_for_steps(type, chapter)]
    else
      [I18n.t('book.voting_step', type: in_type), url_for_steps(type, chapter)]
    end
  end

  def slug_canidates
    [
      :title,
      %i[title genre]
    ]
  end

  def show_path
    polymorphic_url(self, only_path: true)
  end

  def cover_path
    polymorphic_url(cover.variant(resize: '102x156'), only_path: true) if cover.attached?
  end

  def as_json(_args)
    super(methods: %i[cover_path show_path])
  end

  private

  def type_step_chapter
    type, chapter, step = current_step.to_s.split('_')
    step ||= chapter
    type = "#{type}_#{chapter}" if chapter == 'art'
    chapter = nil unless type == 'chapter'
    [type, step, chapter]
  end

  def url_for_steps(type, chapter)
    url_for(controller: type.pluralize, action: 'index', book_id: friendly_id, chapter: chapter, only_path: true)
  end

  def ensure_cover
    return if cover.attached?
    require 'securerandom'

    img_loc = Tempfile.new(["cover-#{SecureRandom.hex}", '.png'])

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
