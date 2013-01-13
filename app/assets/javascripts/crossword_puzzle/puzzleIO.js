/*
Functions to input and output data about the puzzle. Input methods accept
either arrays or comma-separated string representing arrays
*/
// Functions for modifying strings. For use in the puzzle input and output
function removeBrackets(stringWithBrackets){
	return stringWithBrackets.replace(/[\[\]']+/g, '');
}
function removeApostrophes(stringWithApostrophes){
	return stringWithApostrophes.replace(/'/g, '');
}
function sanitizeClue(clueString){
	var newString = clueString.replace(/"/g, '\'\'');
	newString = newString.replace(/\'/g, '\\\'');
	return newString;
}

function outputVoids(){
	var cellString = '';
	var cellArray = new Array();
	for (var i = 0, ii = $cells.length; i < ii; i++){
		if($($cells[i]).hasClass('void')){
			if(cellString.length > 0){
				cellString += ', ';
			} 
			cellString += i;
			cellArray[cellArray.length]=i;
		}
	}
	return cellArray;
}
function inputVoids(voidArray){
	if(Object.prototype.toString.call(voidArray) === '[object String]'){
		voidArray = removeBrackets(voidArray).split(',');
	}
	$cells.removeClass('void');
	for (var i = 0; i < voidArray.length; i++){
		makeVoid($($cells[voidArray[i]]));
	}
}
function outputLetters(){
	var cellArray = new Array();
	for (var i =0; i<$cells.length; i++){
		$cell = $($cells[i]);
		if ($cell.hasClass('void')){
			cellArray[i] = '';
		}
		else {
			cellArray[i] = $cell.val();
		}
	}
	return cellArray;
}
function inputLetters(letterArray){
	if(Object.prototype.toString.call(letterArray) === '[object String]'){
		letterArray = removeBrackets(letterArray).split(',');
	}
	for (var i = 0; i<$cells.length; i++){
		$($cells[i]).val(letterArray[i]);
	}
}
function outputLetterVoids(){
		var cellString = '';
		for (var i=0; i<$cells.length; i++){
				$cell = $($cells[i]);
				if ($cell.hasClass('void')){
						cellString += '_';
				}
				else if ($cell.val() ==''){
						cellString += ' ';
				}
				else {
						cellString += $cell.val();
				}
		}
		return cellString;
}

function outputClues(){
	var clueString = '[';
	var $numberedCells = $('.cell[cellnumber != "-1"]');
	for (var i = 0; i< $numberedCells.length; i++){
		var $cell = $($numberedCells[i]);
		if(i==0){
			if(hasAcrossClue($cell)){
				clueString += ('{"Across":"'+$cell.attr('acrossClue')+'",');
			}
			else {
				clueString += '{"Across":"",';
			}
			if(hasDownClue($cell)){
				clueString += ('"Down":"' + $cell.attr('downClue')+'"}');
			}
			else {
				clueString += '"Down":""}';
			}
		} 
		else {
			if(hasAcrossClue($cell)){
				clueString += (',{"Across":"'+$cell.attr('acrossClue')+'",');
			}
			else {
				clueString += ',{"Across":"",';
			}
			if(hasDownClue($cell)){
				clueString += ('"Down":"' + $cell.attr('downClue')+'"}');
			}
			else {
				clueString += '"Down":""}';
			}
		}
	}
	clueString += ']';
	return clueString;
}
function inputClues(JSONClueString){
	var arrayOfAssociativeClueArray = JSON.parse(JSONClueString);
	for(var i = 0; i< arrayOfAssociativeClueArray.length; i++){
		if(arrayOfAssociativeClueArray[i]['Across']){
			$('.cell[cellnumber ='+ (i+1)+']').attr('acrossclue',arrayOfAssociativeClueArray[i]['Across']);
		}
		if(arrayOfAssociativeClueArray[i]['Down']){
			$('.cell[cellnumber ='+(i+1)+']').attr('downclue',arrayOfAssociativeClueArray[i]['Down']);
		}
	}	
}