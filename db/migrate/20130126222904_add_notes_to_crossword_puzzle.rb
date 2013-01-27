class AddNotesToCrosswordPuzzle < ActiveRecord::Migration
  def change
    add_column :crossword_puzzles, :notes, :text
  end
end
