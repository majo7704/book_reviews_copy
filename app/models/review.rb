class Review < ApplicationRecord
validates :title, presence: true
validates :author, length: {maximum: 100}

belongs_to :user

has_many :comments, :dependent=>:destroy



has_and_belongs_to_many :users

def self.most_recent()
    all.order(created_at: :desc).limit(6)
  end

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    Review.where('title LIKE ?', wildcard_filter).or(where('author LIKE ?', wildcard_filter))
  end

end
