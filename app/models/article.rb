class Article < ApplicationRecord
  has_many :users_articles, dependent: :destroy
  has_many :users, through: :users_articles
end
