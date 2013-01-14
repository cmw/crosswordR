class User < ActiveRecord::Base
  has_many :crossword_puzzles
  has_many :clues, :through => :crossword_puzzles
  has_many :crossword_solutions
	
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  MAX_EMAIL_LENGTH = 25
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
  	:presence => true,
  	:uniqueness => true,
  	:length => { :maximum => MAX_EMAIL_LENGTH, :message => "That's just too long. Your email shouldn't be above #{MAX_EMAIL_LENGTH} characters" },
   	:format => { with: VALID_EMAIL_REGEX, :message => ": Only real email addresses, please" } 
  
  MAX_USERNAME_LENGTH = 12
  MIN_USERNAME_LENGTH = 4
  validates :username,
  	:presence => true,
  	:uniqueness => true,
  	:length => { :minimum => MIN_USERNAME_LENGTH, :maximum => MAX_USERNAME_LENGTH, :message => ": Should be #{MIN_USERNAME_LENGTH}-#{MAX_USERNAME_LENGTH} characters"}

	MIN_NAME_LENGTH = 2
	validates :first_name,
		:presence => true,
		:length => { :minimum => MIN_NAME_LENGTH, :message => ": Should be at least #{MIN_NAME_LENGTH} characters"}
		validates :last_name,
		:presence => true,
		:length => { :minimum => MIN_NAME_LENGTH, :message => ": Should be at least #{MIN_NAME_LENGTH} characters"}
	
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :username

  def self.authenticate(username, password)
  	user = find_by_username(username)
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  	  user
  	else
  	  nil
  	end
  end
  
  def has_published
  	return self.crossword_puzzles.where(:published => true).count > 0
  end

  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt) 		
  	end
  end
  
  
end
