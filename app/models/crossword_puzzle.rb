class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  attr_accessible :clues, :cols, :letters, :rows, :title, :user_id, :voids
end
