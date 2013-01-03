class User < ActiveRecord::Base
  has_many :crossword_puzzles
  has_many :clues, :through => :crossword_puzzles
	
  attr_accessor :password
  validates_confirmation_of :password
  
  validates_presecence_of :attribute, :on => :create, :message => "can't be blank"

  attr_accessible :admin, :clues_count, :crossword_puzzles_count, :email, :first_name, :last_name, :password_hash, :password_salt, :username
end
