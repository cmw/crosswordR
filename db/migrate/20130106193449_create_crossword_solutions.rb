class CreateCrosswordSolutions < ActiveRecord::Migration
  def change
    create_table :crossword_solutions do |t|
      t.integer :crossword_puzzle_id
      t.integer :user_id
      t.text :solution_letters
      t.boolean :solution_complete, :default => false

      t.timestamps
    end
  end
end
