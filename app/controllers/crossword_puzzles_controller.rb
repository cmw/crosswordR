class CrosswordPuzzlesController < ApplicationController

  # GET /crossword_puzzles
  # GET /crossword_puzzles.json
  def index
    @crossword_puzzles = CrosswordPuzzle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crossword_puzzles }
    end
  end

  # GET /crossword_puzzles/1
  # GET /crossword_puzzles/1.json
  def show
    @crossword_puzzle = CrosswordPuzzle.find(params[:id])

    #Creates a solution for the puzzle by the user
    unless (current_user.nil? || @crossword_puzzle.nil?)
      @crossword_solution = CrosswordSolution.find_or_create_by_user_id_and_crossword_puzzle_id(current_user.id, @crossword_puzzle.id)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @crossword_puzzle }
    end
  end

  # GET /crossword_puzzles/new
  # GET /crossword_puzzles/new.json
  def new
    @crossword_puzzle = CrosswordPuzzle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @crossword_puzzle }
    end
  end

  # GET /crossword_puzzles/1/edit
  def edit
    @crossword_puzzle = CrosswordPuzzle.find(params[:id])

    unless current_user && ( (current_user == @crossword_puzzle.user) || current_user[:admin] )
      redirect_to root_url, :notice => "Sorry, you can't edit other people's puzzles"
    end
  end

  # POST /crossword_puzzles
  # POST /crossword_puzzles.json
  def create
    @crossword_puzzle = CrosswordPuzzle.new(params[:crossword_puzzle])
    if !@crossword_puzzle.user && current_user
    	@crossword_puzzle.user = current_user
    end

    respond_to do |format|
      if @crossword_puzzle.save
      	if current_user.admin
					format.html { redirect_to @crossword_puzzle, notice: 'Crossword puzzle was successfully created.' }
      	else
					format.html{ redirect_to edit_crossword_puzzle_path(@crossword_puzzle), :notice => "Puzzle created!" }
      	end
				format.json { render json: @crossword_puzzle, status: :created, location: @crossword_puzzle }
      else
        format.html { render action: "new" }
        format.json { render json: @crossword_puzzle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /crossword_puzzles/1
  # PUT /crossword_puzzles/1.json
  def update
    @crossword_puzzle = CrosswordPuzzle.find(params[:id])

    respond_to do |format|
      if @crossword_puzzle.update_attributes(params[:crossword_puzzle])
        format.html { redirect_to edit_crossword_puzzle_path(@crossword_puzzle), notice: 'Puzzle saved!' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit", notice: 'Error while saving.' }
        format.json { render json: @crossword_puzzle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crossword_puzzles/1
  # DELETE /crossword_puzzles/1.json
  def destroy
    @crossword_puzzle = CrosswordPuzzle.find(params[:id])
    @crossword_puzzle.destroy

    respond_to do |format|
    	if current_user.admin
      format.html { redirect_to crossword_puzzles_url, notice: 'Puzzle successfully deleted.' }
      else
			format.html { redirect_to root_url, notice: 'Crossword puzzle successfully deleted.' }
      end
			format.json { head :no_content }
      format.js
    end
  end
end
