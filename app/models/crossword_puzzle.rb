class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user

  attr_accessible :clues, :cols, :creator, :letters, :rows, :title, :voids
end
