class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user

  attr_accessible :clues, :cols, :letters, :rows, :title, :user_id, :voids
end
