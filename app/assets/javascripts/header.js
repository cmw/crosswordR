$(document).ready(function(){	
	$('.menuTab').on('mouseenter', function(){
		$(this).find('.dropMenu').stop().fadeIn(60);
	});
	$('.menuTab').on('mouseleave', function(){
		$(this).find('.dropMenu').stop().fadeOut(50);
	});
	$('.dropMenu li').on('mouseenter', function(){
		$(this).find('.leftMenu').stop().fadeIn(60);
	});
	$('.dropMenu li').on('mouseleave', function(){
		$(this).find('.leftMenu').stop().fadeOut(50);
	});
});