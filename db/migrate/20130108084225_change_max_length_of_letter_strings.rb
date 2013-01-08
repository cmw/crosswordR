class ChangeMaxLengthOfLetterStrings < ActiveRecord::Migration
  def up
  	change_column :crossword_puzzles, :letters, :string, :limit => 1000
  end

  def down
  	change_column :crossword_puzzles, :letters, :string, :limit => nil
  end
end