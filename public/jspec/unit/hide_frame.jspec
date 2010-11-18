
describe 'Animator - Displaying Frame when Big Cards are not visible'

  before_each
	  cards = elements('<div id="cards"/>')
	  frame = elements('<div id="frame"/>')
		animator = new Animator(cards, frame, '../')
		animator.bringInFrame();
		Clock.tick(4000) // plenty of time for the cards animation
  end

  after_each
    cards = null
    frame = null
		animator = null
  end

  describe 'takeOutFrame()'
	  it 'will hide the frame menu using an animation'
			animator.takeOutFrame()
			frame.find('#frame-menu').should.be_visible

			Clock.tick(200)

			frame.find('#frame-menu').should.be_hidden
	  end

	  it 'will hide the frame small front card using an animation'
			animator.takeOutFrame()
			Clock.tick(200)  // menu animation
			
			frame.find('#card-front').css('left').should.be "-100px"
			frame.find('#card-front').css('top').should.be "-80px"

			Clock.tick(1000)

			frame.find('#card-front').css('left').should.be "-300px"
			frame.find('#card-front').css('top').should.be "-380px"
			Clock.tick(2000)
	  end

	  it 'will hide the frame small back card using an animation'
			animator.takeOutFrame()
			Clock.tick(200)  // menu animation
			
			frame.find('#card-back').css('left').should.be "-40px"
			frame.find('#card-back').css('top').should.be "150px"

			Clock.tick(500)

			frame.find('#card-back').css('left').should.be "-340px"
			frame.find('#card-back').css('top').should.be "-280px"
	  end

	  it 'will hide the frame placeholder using an animation'
			animator.takeOutFrame()
			Clock.tick(200)  // menu animation
			Clock.tick(1000) // cards animation

			Clock.tick(500)
			frame.should.be_hidden
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.takeOutFrame(function(){ callback_called = true })
			Clock.tick(200)  // menu animation
			Clock.tick(1000) // cards animation
			Clock.tick(500)  // frame animation
			
			callback_called.should.be true
	  end
	end

end
