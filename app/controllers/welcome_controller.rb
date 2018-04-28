# frozen_string_literal: true

class WelcomeController < ApplicationController
  include LastPage

  def index
    @manuscripts = Book.manuscripts.page(1).per(8)
    @manuscripts_complete = last_page? @manuscripts
    @most_reads = Book.completes.page(1).per(8)
    @most_reads_complete = last_page? @most_reads
    @genres = Book.genres.keys.each_with_object({}) do |genre, hsh|
      books = Book.all.where(genre: genre).page(1).per(8)
      hsh[genre] = [books, last_page?(books)]
    end
  end
end
