class Topic < ApplicationRecord
	has_many :articles
	has_many :users, through: :articles, source: :author
end