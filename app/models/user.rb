class User < ActiveRecord::Base
	before_save {self.email = self.email.downcase} #self significa o usuario atual (current_user)
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	# def self.sign_in_from_omniauth(auth)
	# 	find_by(provider: auth['provider'], uid: auth['uid']) || create_face_user_from_omniauth(auth)
	# end

	# def self.create_face_user_from_omniauth(auth)	
	# 	user = User.new
	# 	user = create(
	# 		provider: auth['provider'],
	# 		uid: auth['uid'],
	# 		name: auth['info']['name']
	# 		)
 #   		user
	# end

	def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.password = '123456'
    user.password_confirmation = '123456'
    user.save!
    user
  end
end
