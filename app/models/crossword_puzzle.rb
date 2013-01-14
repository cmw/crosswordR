class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :clues
  has_many :crossword_solutions

  attr_accessible :clues_count, :cols, :letters, :published, :rows, :title, :user_id

	MIN_DIMENSION = 2
  MAX_DIMENSION = 30
  
  validates :cols,
  	:presence => true,
  	:length => { :minimum => MIN_DIMENSION, :maximum => MAX_DIMENSION, :message => ": Dimensions must be #{MIN_DIMENSION}-#{MAX_DIMENSION} in length"}

  validates :rows,
  	:presence => true,
  	:length => { :minimum => MIN_DIMENSION, :maximum => MAX_DIMENSION, :message => ": Dimensions must be #{MIN_DIMENSION}-#{MAX_DIMENSION} in length"}

end