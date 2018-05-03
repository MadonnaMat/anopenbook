# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    genre Book.genres[:crime]
    title 'Book'
    current_step Book.current_steps[:complete]

    factory :new_book do
      title 'New Manuscript'
      current_step Book.current_steps[:synopsis_submission]
    end
  end
end
