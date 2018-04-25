# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @manuscripts = Book.manuscripts.page(1).per(8)
    @manuscripts_complete = @manuscripts.last_page?
    @most_reads = Book.completes.page(1).per(8)
    @most_reads_complete = @most_reads.last_page?
    @genres = Book.genres.keys.each_with_object({}) do |genre, hsh|
      books = Book.all.where(genre: genre).page(1).per(8)
      hsh[genre] = [books, books.last_page?]
    end
  end
end
