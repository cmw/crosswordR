class RemoveCluesFromCrosswordPuzzle < ActiveRecord::Migration
  def up
    remove_column :crossword_puzzles, :clues
  end

  def down
    add_column :crossword_puzzles, :clues, :string
  end
end
