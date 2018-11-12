# frozen_string_literal: true

class Synopsis < Submission
  acts_as_votable cacheable_strategy: :update_columns
  scope :for_book, ->(book) { where(book_id: book.id) }

  scope :submitted, -> { where(is_submitted: true) }
end
