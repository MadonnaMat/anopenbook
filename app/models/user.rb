# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :fullname

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  friendly_id :username, use: :history

  has_and_belongs_to_many :books
  has_one_attached :avatar
  has_many :submissions
end
