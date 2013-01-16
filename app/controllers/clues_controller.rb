class CluesController < ApplicationController
  before_filter :get_clue, :only => [:show, :edit, :update, :destroy]

  def get_clue
    @clue = Clue.find(params[:id])
  end

  # GET /clues
  # GET /clues.json
  def index
    @clues = Clue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clues }
    end
  end

  # GET /clues/1
  # GET /clues/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clue }
    end
  end

  # GET /clues/new
  # GET /clues/new.json
  def new
    @clue = Clue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clue }
    end
  end

  # GET /clues/1/edit
  def edit

    unless current_user && ( (current_user == @clue.user) || current_user[:admin] )
      redirect_to root_url, :notice => "Sorry, you can't edit other people's clues"
    end

  end

  # POST /clues
  # POST /clues.json
  def create
    @clue = Clue.new(params[:clue])
		if !@clue.user && current_user
    	@clue.user = current_user
    end
    if !@clue.crossword_puzzle && @crossword_puzzle
    	@clue.crossword_puzzle = @crossword_puzzle
    end

    respond_to do |format|
      if @clue.save
        format.html { redirect_to @clue, notice: 'Clue was successfully created.' }
        format.json { render json: @clue, status: :created, location: @clue }
      else
        format.html { render action: "new" }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clues/1
  # PUT /clues/1.json
  def update

    respond_to do |format|
      if @clue.update_attributes(params[:clue])
        format.html { redirect_to @clue, notice: 'Clue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clues/1
  # DELETE /clues/1.json
  def destroy
    @clue.destroy

    respond_to do |format|
      format.html { redirect_to clues_url }
      format.json { head :no_content }
    end
  end
end
