require 'test_helper'

class CrosswordPuzzlesControllerTest < ActionController::TestCase
  setup do
    @crossword_puzzle = crossword_puzzles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crossword_puzzles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crossword_puzzle" do
    assert_difference('CrosswordPuzzle.count') do
      post :create, crossword_puzzle: { clues: @crossword_puzzle.clues, cols: @crossword_puzzle.cols, creator: @crossword_puzzle.creator, letters: @crossword_puzzle.letters, rows: @crossword_puzzle.rows, title: @crossword_puzzle.title, voids: @crossword_puzzle.voids }
    end

    assert_redirected_to crossword_puzzle_path(assigns(:crossword_puzzle))
  end

  test "should show crossword_puzzle" do
    get :show, id: @crossword_puzzle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crossword_puzzle
    assert_response :success
  end

  test "should update crossword_puzzle" do
    put :update, id: @crossword_puzzle, crossword_puzzle: { clues: @crossword_puzzle.clues, cols: @crossword_puzzle.cols, creator: @crossword_puzzle.creator, letters: @crossword_puzzle.letters, rows: @crossword_puzzle.rows, title: @crossword_puzzle.title, voids: @crossword_puzzle.voids }
    assert_redirected_to crossword_puzzle_path(assigns(:crossword_puzzle))
  end

  test "should destroy crossword_puzzle" do
    assert_difference('CrosswordPuzzle.count', -1) do
      delete :destroy, id: @crossword_puzzle
    end

    assert_redirected_to crossword_puzzles_path
  end
end
