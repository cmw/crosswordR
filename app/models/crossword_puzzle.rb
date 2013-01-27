class CrosswordPuzzle < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :clues
  has_many :crossword_solutions, :dependent => :destroy

  attr_accessible :clues_count, :cols, :letters, :published, :rows, :title, :user_id

	MIN_DIMENSION = 4
  MAX_DIMENSION = 30
  
  validates :rows,
  	:presence => true,
  	:numericality => { :only_integer => true , :message => ': Must be an integer'},
  	:inclusion => {:in => MIN_DIMENSION..MAX_DIMENSION, :message => ": Dimensions must be #{MIN_DIMENSION}-#{MAX_DIMENSION} in length"}

  validates :cols,
  	:presence => true,
  	:numericality => { :only_integer => true , :message => ': Must be an integer'},
  	:inclusion => {:in => MIN_DIMENSION..MAX_DIMENSION, :message => ": Dimensions must be #{MIN_DIMENSION}-#{MAX_DIMENSION} in length"}


	MIN_TITLE_LENGTH = 3
	MAX_TITLE_LENGTH = 35
		
	validates :title,
  	:presence => true,
  	:length => { :minimum => MIN_TITLE_LENGTH, :maximum => MAX_TITLE_LENGTH, :message => ": Must be #{MIN_TITLE_LENGTH}-#{MAX_TITLE_LENGTH} characters long"}

  scope :published, where(:published => true)
  scope :unpublished, where(:published => false)
  scope :order_recent, order('updated_at DESC')

end