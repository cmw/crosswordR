class User < ActiveRecord::Base
  has_many :crossword_puzzles
  has_many :clues, :through => :crossword_puzzles
  has_many :crossword_solutions, :dependent => :destroy
	
  attr_accessor :password
  before_save :encrypt_password
  after_create :welcome_email

  MIN_PASSWORD_LENGTH = 5
  MAX_PASSWORD_LENGTH = 16
  validates :password,
    :presence => true,
    :confirmation => true,
    :length => { :minimum => MIN_PASSWORD_LENGTH, :maximum => MAX_PASSWORD_LENGTH, :message => ": Should be #{MIN_PASSWORD_LENGTH}-#{MAX_PASSWORD_LENGTH} characters" }
  
  MAX_EMAIL_LENGTH = 25
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
  	:presence => true,
  	:uniqueness => true,
  	:length => { :maximum => MAX_EMAIL_LENGTH, :message => ": That's just too long. Your email shouldn't be above #{MAX_EMAIL_LENGTH} characters" },
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

  def full_name
    if either_name?
      if both_names?
        return self.first_name + " " + self.last_name
      elsif self.first_name?
        return self.first_name
      else
        return self.last_name
      end
    else
      return self.username
    end
  end

  def either_name?
    return (self.first_name? || self.last_name?)
  end

  def both_names?
    return (self.first_name? && self.last_name?)
  end
  
  def has_published
  	return self.crossword_puzzles.published.exists?
  end

  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt) 		
  	end
  end
  
  def rand_owned_puzzle
    CrosswordPuzzle.where('user_id = ?', self.id).order("RANDOM()").first
  end

  def rand_unowned_puzzle
    CrosswordPuzzle.where('user_id != ?', self.id).order("RANDOM()").first
  end

  def welcome_email
    UserMailer.welcome_email(self).deliver
  end
  
end
