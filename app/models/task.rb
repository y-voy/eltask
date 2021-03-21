class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :status, presence: true
  validates :priority, presence: true
  validates :expired_at, presence: true

  belongs_to :user, optional: true
  has_many :label_relations, dependent: :destroy
  has_many :labels, through: :label_relations, source: :label

  paginates_per 10

  enum status: {
    "": 0,
    未着手: 1,
    着手中: 2,
    完了: 3
  }

  enum priority: {
    "--": 0,
    低: 1,
    中: 2,
    高: 3
  }

  scope :name_search, -> (term) {
    where('name LIKE ?', "%#{term}%")
  }

  scope :status_search, -> (term) {
    where('status = ?', "#{term}")
  }

end
