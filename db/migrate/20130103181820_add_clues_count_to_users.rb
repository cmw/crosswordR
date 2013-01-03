class AddCluesCountToUsers < ActiveRecord::Migration
  def self.up  
    add_column :users, :clues_count, :integer, :default => 0  
      
    User.reset_column_information  
    User.find_each do |p|  
      User.reset_counters p.id, :clues
	  User.reset_counters p.id, :crossword_puzzles
    end  
  end
  
  def self.down  
    remove_column :users, :clues_count  
  end 
end
