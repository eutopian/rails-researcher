class User < ApplicationRecord
	before_save :downcase_email, :format_name
  validates :username, presence: true, length: { minimum: 6, maximum: 50 }, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 } 
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 6 }, unless: :has_uid
  has_many :articles, :foreign_key => 'author_id'
  has_many :reviews, :foreign_key => 'reviewer_id'
  has_many :topics, through: :articles
  has_many :comments
  
  def self.create_with_omniauth(auth)
    new_user = self.new do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"] || auth["info"]["nickname"] + "@twitter.com"
      user.username = auth["extra"]["raw_info"]["username"] || auth["info"]["nickname"] || user.email 
    end
    new_user.save
    new_user
  end

  def has_uid
    self.uid?
  end

  def most_commented_topic
    if Topic.joins(articles: :comments).joins(:users).where("user_id = #{self.id}").any?
      Topic.find(Topic.joins(articles: :comments).joins(:users).where("user_id = #{self.id}").group("topics.id").count.max_by {|topic,count| count}[0])
    end
  end

  def most_article_topic
    if Topic.joins(articles: :author).where("author_id = #{self.id}").any?
      Topic.find(Topic.joins(articles: :author).where("author_id = #{self.id}").group("topics.id").count.max_by {|topic,count| count}[0])
    end
  end

  def most_review_topic
    if Topic.joins(articles: :reviews).joins(:users).where("reviewer_id = #{self.id}").any?
      Topic.find(Topic.joins(articles: :reviews).joins(:users).where("reviewer_id = #{self.id}").group("topics.id").count.max_by {|topic,count| count}[0])
    end
  end

  def recommended_topic
    [most_review_topic, most_article_topic, most_commented_topic].uniq
  end

  def name=(name)
    names = name.split(" ")
    self.first_name = names[0]
    self.last_name = names[-1]
  end

protected
	def name_format(name)
		name.downcase
		([name.split("").first.upcase] << [(name.split("").drop(1)).join("")]).join
	end

  def format_name
    self.first_name = name_format(first_name)
    self.last_name = name_format(last_name)
  end

  def downcase_email
    self.email = email.downcase
  end
end