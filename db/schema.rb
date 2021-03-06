# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130127085202) do

  create_table "clues", :force => true do |t|
    t.integer   "crossword_puzzle_id"
    t.integer   "user_id"
    t.integer   "cell"
    t.boolean   "orientation"
    t.string    "clue_text"
    t.timestamp "created_at",          :null => false
    t.timestamp "updated_at",          :null => false
    t.string    "direction"
    t.integer   "word_id"
  end

  create_table "crossword_puzzles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "rows"
    t.integer  "cols"
    t.string   "letters",                   :limit => 1000, :default => ""
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "clues_count",                               :default => 0
    t.integer  "crossword_solutions_count",                 :default => 0
    t.boolean  "published",                                 :default => false
    t.text     "notes"
  end

  create_table "crossword_solutions", :force => true do |t|
    t.integer  "crossword_puzzle_id"
    t.integer  "user_id"
    t.text     "solution_letters",    :default => ""
    t.boolean  "solution_complete",   :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "username"
    t.string    "email"
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
    t.boolean   "admin",                     :default => false
    t.integer   "crossword_puzzles_count",   :default => 0
    t.integer   "clues_count",               :default => 0
    t.string    "password_hash"
    t.string    "password_salt"
    t.integer   "crossword_solutions_count", :default => 0
  end

  create_table "words", :force => true do |t|
    t.string   "word"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
