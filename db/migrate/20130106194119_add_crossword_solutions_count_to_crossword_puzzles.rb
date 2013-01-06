class AddCrosswordSolutionsCountToCrosswordPuzzles < ActiveRecord::Migration
  def self.up  
    add_column :crossword_puzzles, :crossword_solutions_count, :integer, :default => 0  
      
    CrosswordPuzzle.reset_column_information  
    CrosswordPuzzle.find_each do |p|  
      CrosswordPuzzle.reset_counters p.id, :clues
	  	CrosswordPuzzle.reset_counters p.id, :crossword_solutions
    end  
  end
  
  def self.down  
    remove_column :crossword_puzzles, :crossword_solutions_count  
  end
end
