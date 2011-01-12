
describe 'Animator - Displaying Frame when Big Cards are not visible'

  before_each
	  cards = elements('<div id="cards"/>')
	  frame = elements('<div id="frame"/>')
		animator = new Animator(cards, frame, '../')
  end

  after_each
    cards = null
    frame = null
		animator = null
  end

  describe 'bringInFrame()'
	  it 'will display the frame placeholder using an animation'
			animator.bringInFrame()
			Clock.tick(1000)
			frame.should.be_visible
	  end

	  it 'will display the frame small front card using an animation'
			animator.bringInFrame()
			Clock.tick(1000) // frame animation
			
			frame.find('#card-front').css('left').should.be "-500px"
			frame.find('#card-front').css('top').should.be "-80px"

			Clock.tick(300)

			frame.find('#card-front').css('left').should.be "-100px"
			frame.find('#card-front').css('top').should.be "-80px"
	  end

	  it 'will display the frame small back card using an animation'
			animator.bringInFrame()
			Clock.tick(1000) // frame animation
			
			frame.find('#card-back').css('left').should.be "-500px"
			frame.find('#card-back').css('top').should.be "150px"

			Clock.tick(800)

			frame.find('#card-back').css('left').should.be "-40px"
			frame.find('#card-back').css('top').should.be "150px"
	  end

	  it 'will display the frame menu using an animation'
			animator.bringInFrame()
			Clock.tick(1000) // frame animation
			Clock.tick(1000) // cards animation
			
			frame.find('#frame-menu').should.be_hidden

			Clock.tick(200)

			frame.find('#frame-menu').should.be_visible
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.bringInFrame(function(){ callback_called = true })
			Clock.tick(1000) // frame animation
			Clock.tick(1000) // cards animation
			Clock.tick(200)  // menu animation
			
			callback_called.should.be true
	  end
	end

end
