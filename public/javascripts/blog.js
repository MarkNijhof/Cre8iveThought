
var scroll_top = 15;
var to_show_the_profile_picture = true;
var to_hide_the_profile_picture = false;

$(window).scroll(function () {  
	check_if_an_annimation_is_needed();
});

function check_if_an_annimation_is_needed(){
	if (is_currently_below_scroll_top()) {
		start_annimation(to_hide_the_profile_picture);
	} else {
		start_annimation(to_show_the_profile_picture);
	}
}

function start_annimation(should_the_profile_picture_be_shown){
	if (should_the_profile_picture_be_shown){
		$('#profile-picture').stop().animate({ width: 222 }, 1000);
	} else {
		$('#profile-picture').stop().animate({ width: 0 }, 300);
	}
}

function is_currently_below_scroll_top(){
	return $(window).scrollTop() >= scroll_top;
}

$(document).ready(function(){
	$('#footer').css('margin-bottom', $(window).height() - 500 + 'px');
});
