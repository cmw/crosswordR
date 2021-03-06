class CrosswordSolutionsController < ApplicationController

  # GET /crossword_solutions
  # GET /crossword_solutions.json
  def index
    @crossword_solutions = CrosswordSolution.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crossword_solutions }
    end
  end

  # GET /crossword_solutions/1
  # GET /crossword_solutions/1.json
  def show
    @crossword_solution = CrosswordSolution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @crossword_solution }
    end
  end

  # GET /crossword_solutions/new
  # GET /crossword_solutions/new.json
  def new
    @crossword_solution = CrosswordSolution.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @crossword_solution }
    end
  end

  # GET /crossword_solutions/1/edit
  def edit
    @crossword_solution = CrosswordSolution.find(params[:id])

    unless current_user && ( (current_user == @crossword_solution.user) || current_user[:admin] )
      redirect_to root_url, :notice => "Sorry, you can't edit other people's solutions"
    end
  end

  # POST /crossword_solutions
  # POST /crossword_solutions.json
  def create
    @crossword_solution = CrosswordSolution.new(params[:crossword_solution])

    if !@crossword_solution.user && current_user
      @crossword_solution.user = current_user
    end

    if !@crossword_solution.crossword_puzzle && @crossword_puzzle
      @crossword_solution.crossword_puzzle = @crossword_puzzle
    end

    respond_to do |format|
      if @crossword_solution.save
        format.html { redirect_to @crossword_solution, notice: 'Crossword solution was successfully created.' }
        format.json { render json: @crossword_solution, status: :created, location: @crossword_solution }
      else
        format.html { render action: "new" }
        format.json { render json: @crossword_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /crossword_solutions/1
  # PUT /crossword_solutions/1.json
  def update
    @crossword_solution = CrosswordSolution.find(params[:id])

    respond_to do |format|
      if @crossword_solution.update_attributes(params[:crossword_solution])
        format.html { redirect_to crossword_puzzle_path(@crossword_solution.crossword_puzzle), notice: 'Solution saved!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @crossword_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def ajax_destroy
    @crossword_solution = CrosswordSolution.find(params[:id])
    @crossword_solution.destroy

    respond_to do |format|
      format.html { redirect_to crossword_solutions_url }
      format.json { head :no_content }
      format.js
    end
  end

  # DELETE /crossword_solutions/1
  # DELETE /crossword_solutions/1.json
  def destroy
    @crossword_solution = CrosswordSolution.find(params[:id])
    @crossword_solution.destroy

    respond_to do |format|
      format.html { redirect_to crossword_solutions_url }
      format.json { head :no_content }
      format.js
    end
  end
end
