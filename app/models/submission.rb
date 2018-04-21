class Submission < ApplicationRecord
  acts_as_votable
  has_paper_trail only: [:body]

  belongs_to :user
  belongs_to :book
  belongs_to :parent, class_name: 'Submission'
end
