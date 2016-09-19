class User < ApplicationRecord
	before_save { self.email = email.downcase, self.first_name = name_format(first_name), self.last_name = name_format(last_name)}
  validates :username, presence: true, length: { minimum: 6, maximum: 50 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 } 
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  has_many :articles, :foreign_key => 'author_id'
  has_many :reviews, :foreign_key => 'reviewer_id'
  has_many :topics, through: :articles


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def most_topic
    topics = []
    counted = Hash.new(0)
    articles = self.articles.all
    articles.each { |art| topics << art.topic }
    topics.each { |t| counted[t["id"]] += 1 }
    counted = Hash[counted.map {|k,v| [k,v.to_i] }]
    Topic.find(counted.max_by {|k,v| v}[0])
  end


protected
	def name_format(name)
		name.downcase
		([name.split("").first.upcase] << [(name.split("").drop(1)).join("")]).join
	end
end