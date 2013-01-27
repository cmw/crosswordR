class AddDefaultToCrosswordPuzzleLetters < ActiveRecord::Migration
  def self.up
  	change_column_default(:crossword_puzzles, :letters, '')
  end

  def self.down
  	change_column_default(:crossword_puzzles, :letters, nil)
  end
end
