
$(window).scroll(function () {  
	var scrollTop = 15;
	var topSpaceTop = '0px'

	if ($(window).scrollTop() >= scrollTop) {
		hide_profile_picture();
	} else {
		show_profile_picture();
	}
});

var is_animating_profile_picture = false;

function show_profile_picture(){
	if ($('#profile-picture').css('width') == '0px' && !is_animating_profile_picture) {
		is_animating_profile_picture = true;
		$('#profile-picture').animate({
			width: 222
		}, 500, function(){	
			is_animating_profile_picture = false;
		});
	}	
}

function hide_profile_picture(){
	if ($('#profile-picture').css('width') == '222px' && !is_animating_profile_picture) {
		is_animating_profile_picture = true;
		$('#profile-picture').animate({
			width: 0
		}, 200, function(){	
			is_animating_profile_picture = false;
		});
	}	
}



$(document).ready(function(){
	$('#footer').css('margin-bottom', $(window).height() - 500 + 'px');
});
