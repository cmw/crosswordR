$(document).ready(function(){	
	$('.menuTab').on('hover', function(){
		$(this).find('.dropMenu').fadeIn(60);
	});
	$('.menuTab').on('mouseleave', function(){
		$(this).find('.dropMenu').fadeOut(200);
	});
	$('.dropMenu li').on('hover', function(){
		$(this).find('.leftMenu').fadeIn(60);
	});
	$('.dropMenu li').on('mouseleave', function(){
		$(this).find('.leftMenu').fadeOut(200);
	});
});