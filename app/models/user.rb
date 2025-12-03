class User < ApplicationRecord
  has_secure_password

  has_many :illusts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_illusts, through: :favorites, source: :illust

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
