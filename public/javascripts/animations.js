
Animator = function(cards, frame, image_location){
	
	_cards = cards;
	_frame = frame;
	_image_location = image_location == undefined ? 'http://cre8ivethought.s3.amazonaws.com/' : image_location;
	_big_cards_are_visible = false;
	_frame_is_visible = false;
	
	_setup_cards(_cards, _image_location);
	_setup_frame(_frame, _image_location);
	
	this.bringInBigCards = function(callBack){		
		if (_frame_is_visible){
			this.takeOutFrame(function(){
				_cards.fadeIn(1000, function(){ _big_cards_are_visible = true; if (callBack != undefined) { callBack(); } });		
			});
		} else {
			_cards.fadeIn(1000, function(){ _big_cards_are_visible = true; if (callBack != undefined) { callBack(); } });		
		}
	};
	
	this.takeOutBigCards = function(callBack){
		_cards.fadeOut(500, function(){ _big_cards_are_visible = false; if (callBack != undefined) { callBack(); } });
	};	
	
	this.bringInFrame = function(callBack){
		var frame = _frame;
		
		if (_big_cards_are_visible){
			this.takeOutBigCards(function(){
				_bringInFrame(frame, function(){
					_bringInCards(frame, function(){
						_bringInMenu(frame, callBack);
					});
				});
			});
		} else {
			_bringInFrame(frame, function(){
				_bringInCards(frame, function(){
					_bringInMenu(frame, callBack);
				});
			});
		}		
	};
	
	this.takeOutFrame = function(callBack){
		var frame = _frame;

		_clearPreviousContent(frame, function(){
			_takeOutMenu(frame, function(){
				_takeOutCards(frame, function(){
					_takeOutFrame(frame, callBack);
				});
			});
		});
	};
	
	this.loadContent = function(returnsContent, callBack){
		
		if (_frame_is_visible){
			_clearPreviousContent(frame, function(){
				_loadContent(_frame, returnsContent, callBack);
			});
		} else {
			this.bringInFrame(function(){
				_loadContent(_frame, returnsContent, callBack);
			});
		}
	}
	
	
	function _bringInFrame(frame, callBack) {
    frame.fadeIn(1000, function(){ _frame_is_visible = true; if (callBack != undefined) { callBack(); } });
	}
				
	function _takeOutFrame(frame, callBack) {
		frame.fadeOut(500, function(){ _frame_is_visible = false; if (callBack != undefined) { callBack(); } });
	}
	
	function _bringInCards(frame, callBack){
		var card_front = frame.find('#card-front');
		var card_back = frame.find('#card-back');
		
		card_front.css({ left: -500, top: -80 });
		card_back.css({ left: -500, top: 150 });

		card_front
			.animate({ left: '+=400' }, 
			300
		);
		card_back
			.delay(400)
			.animate({ left: '+=460' }, 
			400
		);

		if (callBack == undefined)
			return;

		setTimeout(function(){
			callBack();
		}, 1000);
	}
				
	function _takeOutCards(frame, callBack){
		var card_back = frame.find('#card-back');
		var card_front = frame.find('#card-front');
		
		card_back
			.animate({ left: '+=-300', top: '+=-430' }, 
			500
		);

		card_front
			.animate({ left: '+=-200', top: '+=-300' }, 
			1000
		);

		if (callBack == undefined) {
			return;
		}
			
		setTimeout(function(){
			callBack();
		}, 1000);
	}
	
	function _bringInMenu(frame, callBack) {
    frame.find('#frame-menu').fadeIn(200, function(){ if (callBack != undefined) { callBack(); } });
	}
	
	function _takeOutMenu(frame, callBack) {
		frame.find('#frame-menu').fadeOut(200, function(){ if (callBack != undefined) { callBack(); } });
	}
	
	function _loadContent(frame, returnsContent, callBack){
		var item = $('<div>' + returnsContent() + '</div>');
		item.hide();
		
		_frame
			.find('#frame-content')
			.append(item.fadeIn(350));
		
		if (callBack != undefined) { 
			setTimeout(callBack, 400);
		}
	}

	function _clearPreviousContent(frame, callBack){
		var frame_content = frame.find('#frame-content');
		
		if (frame_content.html() != "") { 
			frame_content
				.fadeOut(350, function() {
					frame_content.html('');
					frame_content.fadeIn(1);
				});

			if (callBack != undefined) { 
				setTimeout(function(){ callBack(); }, 400);
			}
		}
		else {
			frame_content.html('');
			if (callBack != undefined){
				callBack();
			}
		}
	}	
	
	
	function _setup_cards(cards, image_location){
		cards.html('<img src="'+ image_location +'images/Cre8iveBusinessCardsPresentation.png" alt="" class="BusineesCards" />');
	}
	
	function _setup_frame(frame, image_location){
		frame.append('<div id="frame-background"></div>');
		frame.append('<div id="card-front"></div>');
		frame.append('<div id="card-back"></div>');
		frame.append('<div id="frame-foreground"></div>');
		frame.append('<div id="frame-content"></div>');
		
		var menu = $('<div id="frame-menu"><ul></ul></div>');
		var ul = menu.find('ul');
		ul.append('<li id="menu-home"><a href="#/">Home</a></li>');
		ul.append('<li id="menu-services"><a href="#/Services">Services</a></li>');
		ul.append('<li id="menu-speaking"><a href="#/Speaking">Speaking</a></li>');
		ul.append('<li id="menu-vision"><a href="#/Vision">Vision</a></li>');
		ul.append('<li id="menu-contact"><a href="#/Contact">Contact</a></li>');		
		frame.append(menu);
	}
	
};
