class AddPublishedToCrosswordPuzzles < ActiveRecord::Migration
  def change
    add_column :crossword_puzzles, :published, :boolean, :default => false
  end
end