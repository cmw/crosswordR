class User < ActiveRecord::Base
  has_many :crossword_puzzles

  attr_accessible :email, :first_name, :last_name, :password, :username
end
