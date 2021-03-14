class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :expired_at, presence: true

  enum status: {
    "": 0,
    未着手: 1,
    着手中: 2,
    完了: 3
  }
end
