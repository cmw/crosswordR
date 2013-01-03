class User < ActiveRecord::Base
  has_many :crossword_puzzles
  has_many :clues, :through => :crossword_puzzles
	
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  attr_accessible :admin, :clues_count, :crossword_puzzles_count, :email, :first_name, :last_name, :password, :password_confirmation, :password_hash, :password_salt, :username

  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt) 		
  	end
  end
end
