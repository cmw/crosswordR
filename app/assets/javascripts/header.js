$(document).ready(function(){	
	$('.menuTab').on('mouseenter', function(){
		$(this).find('.dropMenu').fadeIn(60);
	});
	$('.menuTab').on('mouseleave', function(){
		$(this).find('.dropMenu').fadeOut(50);
	});
	$('.dropMenu li').on('mouseenter', function(){
		$(this).find('.leftMenu').fadeIn(60);
	});
	$('.dropMenu li').on('mouseleave', function(){
		$(this).find('.leftMenu').fadeOut(50);
	});
});