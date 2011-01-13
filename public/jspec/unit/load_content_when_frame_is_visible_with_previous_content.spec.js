
describe 'Animator - Load content when frame is visible with previous content'

  before_each
	  cards = elements('<div id="cards"/>')
	  frame = elements('<div id="frame"/>')
		animator = new Animator(cards, frame, '../')
		animator.loadContent(function(){return "test";})
		Clock.tick(4000) // plenty of time for the cards animation
  end

  after_each
    cards = null
    frame = null
		animator = null
  end

  describe 'loadContent()'
	  it 'will first hide the previous content using an animation'
			animator.loadContent(function(){return "new content";})
			Clock.tick(380)
		
			frame.find('#frame-content').html().should.be ''
	  end

	  it 'will display the content using an animation'
			animator.loadContent(function(){return "new content";})
			Clock.tick(400)  // remove content
			Clock.tick(400)
			
			frame.find('#frame-content').html().should.match /new content/
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.loadContent(function(){return "new content";}, function(){ callback_called = true })
			Clock.tick(400)  // remove content
			callback_called.should.be false
			
			Clock.tick(400)  // content animation
			
			callback_called.should.be true
	  end
	end

end
