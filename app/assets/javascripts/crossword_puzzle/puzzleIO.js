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

function inputVoids(voidArray){
	if(Object.prototype.toString.call(voidArray) === '[object String]'){
		voidArray = removeBrackets(voidArray).split(',');
	}
	$cells.removeClass('void');
	for (var i = 0; i < voidArray.length; i++){
		makeVoid($($cells[voidArray[i]]));
	}
}

function inputLetterArray(letterArray){
	if(Object.prototype.toString.call(letterArray) === '[object String]'){
		letterArray = removeBrackets(letterArray).split(',');
	}
	for (var i = 0; i<$cells.length; i++){
		if(letterArray[i] != ' '){
			$($cells[i]).val(letterArray[i]);
		} else {
			$($cells[i]).val('');
		}
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