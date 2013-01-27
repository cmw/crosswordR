class AddDirectionAndWordIdToClue < ActiveRecord::Migration
  def change
    add_column :clues, :direction, :string
    add_column :clues, :word_id, :integer
  end
end