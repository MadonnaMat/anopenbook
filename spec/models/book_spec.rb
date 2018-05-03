# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'New Manuscript' do
    let(:new_book) { create(:new_book) }

    it 'will have the name "New Manuscript" and a cover' do
      expect(new_book.title).to eq('New Manuscript')
      expect(new_book.cover.attached?).to be true
    end
  end
end
