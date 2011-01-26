
$(window).scroll(function () {  
	var scrollTop = 5;
	var topSpaceTop = '0px'

	if ($(window).scrollTop() > scrollTop) {
		if ($('#profile-picture').css('width') == '222px') {
			$('#profile-picture').animate({
				width: 0
			}, 200);
		}	
	} else {
		if ($('#profile-picture').css('width') == '0px') {
			$('#profile-picture').animate({
				width: 222
			}, 500);
		}
	}
});  

$(document).ready(function(){  
	$('#footer').css('margin-bottom', $(window).height() - 500 + 'px');
});
