class User < ActiveRecord::Base
  has_many :crossword_puzzles
  has_many :clues, :through => :crossword_puzzles

  attr_accessible :admin, :clues_count, :crossword_puzzles_count, :email, :first_name, :last_name, :password, :username
end
