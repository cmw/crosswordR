class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :clues

  attr_accessible :clues_count, :cols, :letters, :rows, :title, :user_id, :voids
end
