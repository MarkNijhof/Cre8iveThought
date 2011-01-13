
describe 'Animator - Hiding Big Cards'

  before_each
	  cards = elements('<div id="cards"/>')
	  frame = elements('<div id="frame"/>')
		animator = new Animator(cards, frame, '../')
		animator.bringInBigCards()
		Clock.tick(2000)
  end

  after_each
    cards = null
    frame = null
		animator = null
  end

  describe 'takeOutBigCards()'
	  it 'will hide the cards placeholder using an animation'
			animator.takeOutBigCards()
			cards.should.be_visible
			Clock.tick(500)
			cards.should.be_hidden
	  end

	  it 'will call a callback function after the animation is finished'
			var callback_called = false
			animator.takeOutBigCards(function(){ callback_called = true })
			Clock.tick(500)
			callback_called.should.be true
	  end
	end

end