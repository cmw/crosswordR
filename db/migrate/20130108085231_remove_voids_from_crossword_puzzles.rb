class RemoveVoidsFromCrosswordPuzzles < ActiveRecord::Migration
  def up
    remove_column :crossword_puzzles, :voids
  end

  def down
    add_column :crossword_puzzles, :voids, :string
  end
end
