class CreateCrosswordPuzzles < ActiveRecord::Migration
  def change
    create_table :crossword_puzzles do |t|
      t.string :title
      t.integer :user_id
      t.integer :rows
      t.integer :cols
      t.string :clues
      t.string :letters
      t.string :voids

      t.timestamps
    end
  end
end
