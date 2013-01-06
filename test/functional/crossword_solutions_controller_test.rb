require 'test_helper'

class CrosswordSolutionsControllerTest < ActionController::TestCase
  setup do
    @crossword_solution = crossword_solutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crossword_solutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crossword_solution" do
    assert_difference('CrosswordSolution.count') do
      post :create, crossword_solution: { crossword_puzzle_id: @crossword_solution.crossword_puzzle_id, solution_complete: @crossword_solution.solution_complete, solution_letters: @crossword_solution.solution_letters, user_id: @crossword_solution.user_id }
    end

    assert_redirected_to crossword_solution_path(assigns(:crossword_solution))
  end

  test "should show crossword_solution" do
    get :show, id: @crossword_solution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crossword_solution
    assert_response :success
  end

  test "should update crossword_solution" do
    put :update, id: @crossword_solution, crossword_solution: { crossword_puzzle_id: @crossword_solution.crossword_puzzle_id, solution_complete: @crossword_solution.solution_complete, solution_letters: @crossword_solution.solution_letters, user_id: @crossword_solution.user_id }
    assert_redirected_to crossword_solution_path(assigns(:crossword_solution))
  end

  test "should destroy crossword_solution" do
    assert_difference('CrosswordSolution.count', -1) do
      delete :destroy, id: @crossword_solution
    end

    assert_redirected_to crossword_solutions_path
  end
end
