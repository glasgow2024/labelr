class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  has_many :impressions, class_name: "Impression", foreign_key: "user_id"

  enum role: {
    staff: 'staff',
    admin: 'admin'
  }
end
