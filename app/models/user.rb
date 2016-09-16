class User < ApplicationRecord
	before_save { self.email = email.downcase, self.first_name = first_name.name_format, self.last_name = last_name.name_format}
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }

protected
	def name_format(name)
		name.downcase
		([name.split("").first.upcase] << [(name.split("").drop(1)).join("")]).join
	end
end