class CrosswordPuzzle < ActiveRecord::Base
  

  attr_accessible :clues, :cols, :creator, :letters, :rows, :title, :voids
end
