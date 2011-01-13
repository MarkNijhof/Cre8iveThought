
describe 'Animator - Load content when frame is visible'

  before_each
	  cards = elements('<div id="cards"/>')
	  frame = elements('<div id="frame"/>')
		animator = new Animator(cards, frame, '../')
		animator.bringInFrame()
		Clock.tick(4000) // plenty of time for the cards animation
  end

  after_each
    cards = null
    frame = null
		animator = null
  end

  describe 'loadContent()'
	  it 'will display the content using an animation'
			animator.loadContent(function(){return "test";})
			Clock.tick(400)
			
			frame.find('#frame-content').html().should.match /test/
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.loadContent(function(){return "test";}, function(){ callback_called = true })
			callback_called.should.be false
			
			Clock.tick(400)  // content animation
			
			callback_called.should.be true
	  end
	end

end
