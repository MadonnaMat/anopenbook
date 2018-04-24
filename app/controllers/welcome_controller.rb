# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @manuscripts = Book.manuscripts.page(1).per(12)
    @manuscripts_complete = @manuscripts.last_page?
  end
end
