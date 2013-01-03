class AddCluesCountToCrosswordPuzzles < ActiveRecord::Migration
   def self.up  
    add_column :crossword_puzzles, :clues_count, :integer, :default => 0  
      
    CrosswordPuzzle.reset_column_information  
    CrosswordPuzzle.find_each do |p|  
      CrosswordPuzzle.reset_counters p.id, :clues 
    end  
  end
  
  def self.down  
    remove_column :crossword_puzzles, :clues_count  
  end 
end