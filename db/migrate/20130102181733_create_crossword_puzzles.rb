class CreateCrosswordPuzzles < ActiveRecord::Migration
  def change
    create_table :crossword_puzzles do |t|
      t.string :title
      t.string :creator
      t.integer :cols
      t.integer :rows
      t.string :voids
      t.string :letters
      t.string :clues

      t.timestamps
    end
  end
end
