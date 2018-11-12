# frozen_string_literal: true

class Submission < ApplicationRecord
  extend FriendlyId
  include CurrentStep
  include Rails.application.routes.url_helpers

  friendly_id :slug_canidates, use: :history

  acts_as_votable cacheable_strategy: :update_columns
  has_paper_trail only: [:body]

  belongs_to :user
  belongs_to :book
  belongs_to :parent, class_name: 'Submission', required: false
  before_save :sanitize_body

  scope :synopses, -> { where(type: 'Synopsis') }
  scope :includeds, -> { where(is_included: true) }

  def slug_canidates
    [
      :title,
      %i[title current_step]
    ]
  end

  def as_json(_args)
    super(methods: %i[author shortend_body sub_path], except: 'body')
  end

  def author
    user.use_real_name? ? user.fullname : user.username
  end

  def shortend_body
    Sanitize.fragment(body).truncate(200, separator: ' ')
  end

  def sub_path
    _, _, chapter = type_step_chapter
    url_for(controller: type.downcase.pluralize, action: 'show', id: friendly_id, book_id: book.friendly_id, chapter: chapter, only_path: true)
  end

  def vote_path
    _, _, chapter = type_step_chapter
    url_for(controller: type.downcase.pluralize, action: 'vote', id: friendly_id, book_id: book.friendly_id, chapter: chapter, only_path: true)
  end

  private

  def type_step_chapter
    type, chapter, step = current_step.to_s.split('_')
    step ||= chapter
    type = "#{type}_#{chapter}" if chapter == 'art'
    chapter = nil unless type == 'chapter'
    [type, step, chapter]
  end

  def sanitize_body
    self.body = sanitize_with_css(body || '')
  end
end
