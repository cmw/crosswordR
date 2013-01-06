class AddCrosswordSolutionsCountToUsers < ActiveRecord::Migration
  def self.up  
    add_column :users, :crossword_solutions_count, :integer, :default => 0  
      
    User.reset_column_information  
    User.find_each do |p|  
      User.reset_counters p.id, :clues
	  	User.reset_counters p.id, :crossword_puzzles
	  	User.reset_counters p.id, :crossword_solutions
    end  
  end
  
  def self.down  
    remove_column :users, :crossword_solutions_count  
  end 
end
