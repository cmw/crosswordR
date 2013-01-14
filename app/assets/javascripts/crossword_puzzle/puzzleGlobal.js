// HTML contents of cells and rows
var cell = '<div class="cellContainer"><input class="cell" type="text" cellnumber=-1 acrossclue=-1 downclue=-1 maxlength="1"></input><div class="cellNum"></div></div>';
var row = '<div class="row"></div>';

// The Crossword Class
function Crossword(voids, letters, clues){
	this.voids = voids;
	this.letters = letters;
	this.clues = clues;
}

//Reference variables used throughout		
var $cells;
var $cellNums;

//Variables defining current crossword's dimensions
var numRows;
var numCols;

// Public counter for counting which cell was last numbered
var cellNumberingCounter = 1;

// Functions for removing the puzzle elements
function deleteCells(){
	$(".cells").remove();
}
function deleteRows(){
	$(".row").remove();
}

//Function to return a cell's index within the array of cells
function getCellIndex(cell){
	return $cells.index(cell);
}

//Functions for using a cell position to find its index or itself
function getCellIndexFromRC(row, col){
	return row*numCols+col;
}
function get$CellfromRC(row, col){
	return $($cells[getCellIndexFromRC(row,col)]);
}

// Functions returning rows and columns of a cell given it or its index
function getRow($cellIndexOr$Cell){
	if (typeof($cellIndexOr$Cell)=="number"){
		return Math.floor($cellIndexOr$Cell)/numRows;
	} else if (typeof($cellIndexOr$Cell)=="object") {
		return Math.floor(getCellIndex($cellIndexOr$Cell)/numRows);
	} else {
		throwIndexCellError();
	}
}
function getCol($cellIndexOr$Cell){
	if (typeof($cellIndexOr$Cell)=="number"){
		return $cellIndexOr$Cell % numCols;
	} else if (typeof($cellIndexOr$Cell)=="object") {
		return getCellIndex($cellIndexOr$Cell) % numCols;
	} else {
		throwIndexCellError();
	}
}

// Functions for determining whether a cell in the crossword is an edge cell.
function isTopRowCell(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return cellIndexOr$Cell<numCols && cellIndexOr$Cell >= 0;
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return getRow(cellIndexOr$Cell) == 0;
	} else {
		throwIndexCellError();
	}
}
function isBotRowCell(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		var finalCell = numCols*numRows-1;
		return cellIndexOr$Cell > finalCell - numCols;
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return getRow(cellIndexOr$Cell) == (numRows-1);
	} else {
		throwIndexCellError();
	}
}
function isLeftColCell(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell) == "number"){
		return cellIndexOr$Cell % numCols == 0;
	} else if (typeof(cellIndexOr$Cell) == "object") {
		return getCol(cellIndexOr$Cell) == 0;
	} else {
		throwIndexCellError();
	}
}
function isRightColCell(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
	return cellIndexOr$Cell % numCols==(numCols-1);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return getCol(cellIndexOr$Cell) == (numCols-1);
	} else {
		throwIndexCellError();
	}
}
function throwIndexCellError(){
	throw new Error("Invalid input. Only cell indices (integers) and cell jQuery objects are allowed.");
}


// Functions returning adjacent cells
function $cellAbove(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return $($cells[cellIndexOr$Cell-numCols]);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return $($cells[getCellIndex(cellIndexOr$Cell)-numCols]);
	} else {
		throwIndexCellError();
	}
}
function $cellBelow(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return $($cells[cellIndexOr$Cell+numCols]);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return $($cells[getCellIndex(cellIndexOr$Cell)+numCols]);
	} else {
		throwIndexCellError();
	}
}
function $cellLeft(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return $($cells[cellIndexOr$Cell-1]);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return $($cells[getCellIndex(cellIndexOr$Cell)-1]);
	} else {
		throwIndexCellError();
	}
}
function $cellRight(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return $($cells[cellIndexOr$Cell+1]);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return $($cells[getCellIndex(cellIndexOr$Cell)+1]);
	} else {
		throwIndexCellError();
	}
}
function $cellOpposite(cellIndexOr$Cell){
	if (typeof(cellIndexOr$Cell)=="number"){
		return $($cells[numCols*numRows-cellIndexOr$Cell]);
	} else if (typeof(cellIndexOr$Cell)=="object") {
		return $($cells[numCols*numRows-getCellIndex(cellIndexOr$Cell)-1]);
	} else {
		throwIndexCellError();
	}
}

//Functions to get the nearest clued cell above or left
function getClueLeft($cell){
	if(hasAcrossClue($cell) && !isVoid($cell)){
		return {'Number':parseFloat($cell.attr('cellnumber')),'Clue':acrossClue($cell)};
	}
	else if (isLeftColCell(getCellIndex($cell)) || isVoid($cell)){
		return false;
	}
	else {
		return getClueLeft($cellLeft($cell));
	}
}
function getClueAbove($cell){
	if(hasDownClue($cell) && !isVoid($cell)){
		return {'Number':parseFloat($cell.attr('cellnumber')),'Clue':downClue($cell)};
	}
	else if (isTopRowCell(getCellIndex($cell)) || isVoid($cell)){
		return false;
	}
	else {
		return getClueAbove($cellAbove($cell));
	}
}
function hasDownClue($cell){
	if($cell.attr('downclue') && ($cell.attr('downclue')!=-1)){
		return true;
	}
	else {
		return false;
	}
}
function hasAcrossClue($cell){
	if($cell.attr('acrossclue') && ($cell.attr('acrossclue')!=-1)){
		return true;
	}
	else {
		return false;
	}
}
function downClue($cell){
	return $cell.attr('downclue');
}
function acrossClue($cell){
	return $cell.attr('acrossclue');
}

//Helper function for making a cell void and toggling a cell void
function makeVoid($cell){
	removeCorrectness($cell);
	$cell.val('');
	$cell.addClass('void');
	if ( $('#autoMirror').attr('checked') && !isVoid($cellOpposite($cell)) ){
		if($cellOpposite($cell).val()){
			if( confirm('Overwrite the "' + $cellOpposite($cell).val().toUpperCase() +'" in mirror cell at ('+ ((getRow($cellOpposite($cell)))+1)+','+ (getCol($cellOpposite($cell))+1) +')?')) {
				makeVoid($cellOpposite($cell));
			}						
		} else {
			makeVoid($cellOpposite($cell));
		}
	}
	numberCells();
}
function toggleVoid($cell){
	if($cell.hasClass('void')){
		$cell.removeClass('void');
		if( $('#autoMirror').attr('checked') && isVoid($cellOpposite($cell)) ){
			toggleVoid($cellOpposite($cell));
		}
	} 
	else {
		makeVoid($cell);
	}
	updateWhiteBlack();
	numberCells();
}

// Helper function to remove correctness from a cell
function removeCorrectness(cell){
	cell.removeClass('correct');
	cell.removeClass('incorrect');
}

//Helper function to say whether a cell is void
function isVoid(cell){
	return cell.hasClass('void');
}

/*
Functions for determining whether adjacent cells are void and thus determining
whether the cell is lone/single.
*/
function hasLetterAbove(cellIndex){
	return ((!isTopRowCell(cellIndex)) && (!$cellAbove(cellIndex).hasClass('void')));
}
function hasLetterBelow(cellIndex){
	return ((!isBotRowCell(cellIndex)) && (!$cellBelow(cellIndex).hasClass('void')));
}
function hasLetterLeft(cellIndex){
	return ((!isLeftColCell(cellIndex)) && (!$cellLeft(cellIndex).hasClass('void')));
}
function hasLetterRight(cellIndex){
	return ((!isRightColCell(cellIndex)) && (!$cellRight(cellIndex).hasClass('void')));
}
function isLoneCell(cellIndex){
	return ((!hasLetterAbove(cellIndex) && !hasLetterBelow(cellIndex)) || (!hasLetterLeft(cellIndex) && !hasLetterRight(cellIndex)));
}

//Function to automatically number the cells of a blank puzzle
function numberCells(){
	clearNumbers();
	cellNumberingCounter = 1;
	for(var i = 0; i<$cells.length; i++){
		$cell = $($cells[i]);
		$cellNum = $($cellNums[i]);
		
		if(!$cell.hasClass('void') && (!isLoneCell(i) || ((($('#skipSingles').length > 0) && !$('#skipSingles').attr('checked'))))){
			if(isTopRowCell(i)){
				addNumber($cell,$cellNum);
			}
			else if (isLeftColCell(i)){
				addNumber($cell,$cellNum);
			} 
			else if($cellAbove(i)){
				if($cellAbove(i).hasClass('void')){
					addNumber($cell,$cellNum);
				} 
				else if($cellLeft(i)){
					if ($cellLeft(i).hasClass('void')){
						addNumber($cell,$cellNum);
					}
				}
			}
		}
	}
	cellNumberingCounter = 1;
}

//Helper function for adding numbers to non-void cells
function addNumber(cell,cellNum){
	cell.attr('cellnumber',cellNumberingCounter);
	cellNum.text(''+cellNumberingCounter);
	cellNumberingCounter+=1;
}

// Functions for clearing various parts of the puzzle
function clearNumbers(){
	$cellNums.text('');
	$cells.attr('cellnumber',-1);
}
function clearVoids(){
	$cells.removeClass('void');
}
function clearLetters(){
	$cells.val('');
}
function clearCorrectness(){
	$cells.removeClass('correct');
	$cells.removeClass('incorrect');
}
function clearCells(){
	clearLetters();
	clearNumbers();
	clearVoids();
	clearCorrectness();
	$('#cheatResult').text('');
}
function clearClues(){
	$cells.attr('acrossclue',-1);
	$cells.attr('downclue',-1);
}
function clearCredits(){
	$('.cwordTitle').text('+');
	$('.cwordCreator').text('+');
	$('.cwordYear').text('');
}
//Updates the puzzle's stats
function updateRCTip() {
	$('#rowDim').text(numRows);
	$('#colDim').text(numCols);
}
function updateWhiteBlack(){
	$('#whiteCellCount').text($('.cell:not(.void)').length);
	$('#blackCellCount').text($('.cell.void').length);
}
function updateStats(){
	updateRCTip();
	updateWhiteBlack();
}


//Clue functions
function getClueOrientation(){	
	if($('#acrossDownAddClue').attr('checked')){
		return 'across';
	}
	else {
		return 'down';
	}
}
function getClueText(){
	return $('#clueForm textarea#clueInput').val();
}
function getClueCellNumber(){
	return $('#clueForm #clueCell').val();
}

//Function to add a clue to a cell
function addClue(clueString, cellNumber, direction){
	$cell = $('.cell[cellnumber='+cellNumber+']');
	if(direction == 'across'){
		$cell.attr('acrossclue',clueString);
	}
	else if (direction == 'down'){
		$cell.attr('downclue',clueString);
	}
}

/*
Checks the cells that the user has filled against the answers for the current puzzle.
Fills in incorrect answers and highlights them red, while highlighting correct answers green.
*/
function cheat(){
	correctLetters = 0;
	totalLetters = 0;
	for(var i = 0; i< $cells.length; i++){
		$cell = $($cells[i]);
		if (!$cell.hasClass('void')){
			totalLetters += 1;
			if(($cell.val().toLowerCase() === currentCrossword.letters[i].toLowerCase()) && (!$cell.hasClass('incorrect'))){
				correctLetters += 1;
				$cell.addClass('correct');
			}
			else {
				$cell.addClass('incorrect');
				$cell.val(currentCrossword.letters[i]);
			}
		
		}
	}
	var congrats = (correctLetters > 0.8*totalLetters)? 'Awesome job!' : 'Sucks, brah.';
	$('#cheatResult').css({opacity: 1}).text('You got '+ correctLetters + ' out of ' + totalLetters+' correct. ' + congrats);
}
function showIncorrect(){
	var incorrectLetters = 0;
	for(var i = 0; i< $cells.length; i++){
		$cell = $($cells[i]);
		if (!$cell.hasClass('void')){
			if(($cell.val().toLowerCase() !== currentCrossword.letters[i].toLowerCase()) && !$cell.hasClass('incorrect')){
				$cell.removeClass('correct');
				$cell.addClass('flashRed');
			} else if ( ($cell.val().toLowerCase() == currentCrossword.letters[i].toLowerCase())  && (!$cell.hasClass('correct')) ){
				$cell.addClass('correct');
			}
		}
	}
	if($('.flashRed').length == 0){
		$('#cheatResult').text('You solved the puzzle!').animate({opacity: 1}, 'fast','linear');
	} else {
		$('#cheatResult').text('Still ' + $('.flashRed').length + ' letters to solve!').animate({opacity: 1},500, 'linear').delay(1000);
		$('.flashRed').animate({backgroundColor: 'rgba(255,192,203,1)'}, 400,'linear').delay(600).animate({backgroundColor: 'rgba(255,255,255,0)'}, 800, 'linear').removeClass('flashRed');
		$('#cheatResult').animate({opacity: 0},'medium');
	}
}

function toggleAdvanced(){
	$('#pen').toggleClass('hidden');
	$('#advControls').toggleClass('hidden');
}

function toggleText($object,text1,text2){
	if($object.text()==text1){
		$object.text(text2);
	} else if ($object.text() == text2){
		$object.text(text1);
	} else {
		throw new Error("Not toggling");
	}
}

function loadCrossword(crossword){
	clearCells();
	clearClues();
	inputVoids(crossword.voids);
	numberCells();
	currentCrossword = crossword;
	inputClues(crossword.clues);
	updateStats();
	solveMode();
}
function newCrossword(){
	clearCells(); 
	clearClues(); 
	currentCrossword=new Crossword([],[],[]); 
	clearCredits();
	editMode();
}
function updateHiddenLetters(){
	$('#hiddenLetters').val(outputLetterVoids());
}