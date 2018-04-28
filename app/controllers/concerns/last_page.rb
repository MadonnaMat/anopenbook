# frozen_string_literal: true

module LastPage
  extend ActiveSupport::Concern

  included do
    def last_page?(paginated)
      paginated.last_page? || paginated.empty?
    end
  end
end
