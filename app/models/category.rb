class Category < ActiveRecord::Base
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  #TODO: Here we will validate the uniqueness of the name
  validates_uniqueness_of :name
end