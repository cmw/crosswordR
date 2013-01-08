class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :clues
  has_many :crossword_solutions

  attr_accessible :clues_count, :cols, :letters, :published, :rows, :title, :user_id
end