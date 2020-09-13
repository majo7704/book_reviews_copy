class User < ApplicationRecord
  has_many :comments
  has_many :reviews

  has_and_belongs_to_many :bookmarks, class_name: 'Review', dependent: :destroy

  has_secure_password

  validates :email, uniqueness: true

end
