class Clue < ActiveRecord::Base
    belongs_to :user, :counter_cache => true
    belongs_to :crossword_puzzle, :counter_cache => true

  	attr_accessible :cell, :clue_text, :crossword_puzzle_id, :orientation, :user_id

  	def clue_html 
  		return self.clue_text.gsub("&gt;",">").gsub("&lt;","<")
  	end

end
