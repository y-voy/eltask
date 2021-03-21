class User < ApplicationRecord
  has_secure_password

  before_destroy :not_destroy_last_admin

  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  def not_destroy_last_admin
    if self.admin?
      throw(:abort) if User.where(admin: true).count == 1
    end
  end

end
