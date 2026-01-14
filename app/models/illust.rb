class Illust < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true

  # 検索
  scope :search, ->(q) {
    return all if q.blank?
    where("title LIKE :q OR description LIKE :q", q: "%#{q}%")
  }

  # ソート
  scope :sorted, ->(sort) {
    case sort
    when "newest"
      order(created_at: :desc)
    when "oldest"
      order(created_at: :asc)
    when "title_asc"
      order(title: :asc)
    when "title_desc"
      order(title: :desc)
    else
      order(created_at: :desc)
    end
  }
end
