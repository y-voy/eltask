class Label < ApplicationRecord

  has_many :label_relations, dependent: :destroy
  has_many :tasks, through: :label_relations, source: :task

end
