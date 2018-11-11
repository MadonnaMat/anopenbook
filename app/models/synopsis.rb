# frozen_string_literal: true

class Synopsis < Submission
  scope :for_book, ->(book) { where(book_id: book.id) }

  scope :submitted, -> { where(is_submitted: true) }
end
