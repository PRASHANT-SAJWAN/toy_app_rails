class User < ApplicationRecord
  has_many :post
  validates :email, presence: true, uniqueness: true
end
