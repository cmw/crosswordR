$(document).ready(function(){
	$('.top-notice').delay(1200).fadeOut(500);

	$('a.closeBox').on('click', function(e){
		e.preventDefault();
		var par = $(this).parent();
		console.log('sup');
		if($(this).hasClass('closeUp')){
			par.slideUp();
		} else if ($(this).hasClass('closeDown')){
			par.slideDown();
		} else if ($(this).hasClass('closeLeft')){
			par.slideLeft();
		} else if ($(this).hasClass('closeRight')){
			par.slideRight();
		} else {
			par.hide();
		}
	})
});