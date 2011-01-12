
(function($){

	  $.fn.___animate = $.fn.animate;
	$.fn.animate = function(options, duration, callBack){
	    var ___this = $(this);
	
	    setTimeout(function(){
				___this.___animate(options, 0);

	      if (callBack != undefined)
	        callBack();
	    }, duration);
	    return this;
	  };

  $.fn.___fadeIn = $.fn.fadeIn;
	$.fn.fadeIn = function(duration, callBack){
    var ___this = $(this);
    setTimeout(function(){
      ___this.___fadeIn(0);
      ___this.css('display', 'block'); // Added because it will always be hidden, since the tests are not shown
      if (callBack != undefined)
        callBack();
    }, duration);
    return this;
  };

  $.fn.___fadeOut = $.fn.fadeOut;
	$.fn.fadeOut = function(duration, callBack){
    var ___this = $(this);
    setTimeout(function(){
      ___this.___fadeOut(0);
      ___this.css('display', 'none'); // Added because it will always be hidden, since the tests are not shown
      if (callBack != undefined)
        callBack();
    }, duration);
    return this;
  };

  $.fn.___slideUp = $.fn.slideUp;
	$.fn.slideUp = function(duration, callBack){
    var ___this = $(this);
    setTimeout(function(){
      ___this.___slideUp(0);
      ___this.css('display', 'none'); // Added because it will always be hidden, since the tests are not shown
      if (callBack != undefined)
        callBack();
    }, duration);
    return this;
  };

  $.fn.___slideDown = $.fn.slideDown;
	$.fn.slideDown = function(duration, callBack){
    var ___this = $(this);
    setTimeout(function(){
      ___this.___slideDown(0);
      ___this.css('display', 'block'); // Added because it will always be hidden, since the tests are not shown
      if (callBack != undefined)
        callBack();
    }, duration);
    return this;
  };

})(jQuery);

