
describe 'Animator - Displaying Big Cards when Frame is not visible'

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

  describe 'bringInBigCards()'
	  it 'will display the cards placeholder using an animation'
			animator.bringInBigCards()
			Clock.tick(1000)
			cards.should.be_visible
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.bringInBigCards(function(){ callback_called = true })
			Clock.tick(1000)
			callback_called.should.be true
	  end
	end

end
