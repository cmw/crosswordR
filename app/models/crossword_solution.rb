class CrosswordSolution < ActiveRecord::Base
	belongs_to :user, :counter_cache => true
	belongs_to :crossword_puzzle, :counter_cache => true
	
	
  attr_accessible :crossword_puzzle_id, :solution_complete, :solution_letters, :user_id
end
