class CrosswordSolution < ActiveRecord::Base
	belongs_to :user, :counter_cache => true
	belongs_to :crossword_puzzle, :counter_cache => true
	
 	attr_accessible :crossword_puzzle_id, :solution_complete, :solution_letters, :user_id

 	validates :user_id,
 		:presence => true,
 		:uniqueness => {:scope => :crossword_puzzle_id}


 	def completion_percentage
 		sol_letters = self.solution_letters.gsub("_","")
 		puz_letters = self.crossword_puzzle.letters.gsub("_","")
 		return ((sol_letters.length.to_f)/(puz_letters.length.to_f)*100).round(1)
 	end

end
