class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.integer :crossword_puzzle_id
      t.integer :user_id
      t.integer :cell
      t.boolean :orientation
      t.string :clue_text

      t.timestamps
    end
  end
end
