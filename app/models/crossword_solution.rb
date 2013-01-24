class CrosswordSolution < ActiveRecord::Base
	belongs_to :user, :counter_cache => true
	belongs_to :crossword_puzzle, :counter_cache => true

	before_save :check_completion
	
 	attr_accessible :crossword_puzzle_id, :solution_complete, :solution_letters, :user_id

 	validates :user_id,
 		:presence => true,
 		:uniqueness => {:scope => :crossword_puzzle_id}

	def check_completion
		self.solution_complete = (self.solution_letters == self.crossword_puzzle.letters)
		true
	end

 	def completion_percentage
 		sol_letters = self.solution_letters.gsub("_","").gsub(" ","")
 		puz_letters = self.crossword_puzzle.letters.gsub("_","").gsub(" ","")
 		return ((sol_letters.length.to_f)/(puz_letters.length.to_f)*100).round(1)
 	end

	scope :complete, where(:solution_complete => true)
	scope :incomplete, where(:solution_complete => false)
	scope :order_recent, order('updated_at DESC')



end
