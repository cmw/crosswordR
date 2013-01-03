class AddCrosswordPuzzlesCountToUsers < ActiveRecord::Migration
   def self.up  
    add_column :users, :crossword_puzzles_count, :integer, :default => 0  
      
    User.reset_column_information  
    User.all.each do |p|  
      p.update_attribute :crossword_puzzles_count, p.crossword_puzzles.length  
    end  
  end  
  
  def self.down  
    remove_column :users, :crossword_puzzles_count  
  end 
end
