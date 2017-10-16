class UsersArticle < ApplicationRecord
  belongs_to :articles
  belongs_to :users
end
