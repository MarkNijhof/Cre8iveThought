title: Specifications
author: Mark Nijhof
published: true
words: 1,930
characters: 10,972
readingTime: '00:09:39'
keywords: cqrs,design,testing
add_trailing_slash_for_disqus: true

I received a couple questions about the Specification Framework that I use in the [CQRS example](http://github.com/MarkNijhof/Fohjin/tree/f85a25181b4fa382bd3afbbbbcb08da891cc8e45/Fohjin.DDD.Example)  and thought lets talk about that for a bit. The first thing that should be underlined is that this is _not_ a framework, they are a [few classes and extension methods](http://github.com/MarkNijhof/Fohjin/tree/f85a25181b4fa382bd3afbbbbcb08da891cc8e45/Fohjin.DDD.Example/Test.Fohjin.DDD) that rely on [NUnit](http://www.nunit.org/index.php) for the actual assertions and and [Moq](http://code.google.com/p/moq/) for mocking of the dependencies. I got the initial bits from Greg Young at his DDD course which I extended a little bit for my specific needs.

I have the following base test fixture classes:

1. BaseTestFixture
2. BaseTestFixture<TSubjectUnderTest>
3. AggregateRootTestFixture<TAggregateRoot>
4. CommandTestFixture<TCommand, TCommandHandler, TAggregateRoot>
5. EventTestFixture<TEvent, TEventHandler>
6. PresenterTestFixture<TPresenter>

These different classes are all very specific towards a specific need, which is a direct opposite from what a framework usually provides.

##Black box##

I try my best to make my tests treat the subject under test (SUT) as a black box, meaning that in my tests I don’t directly interact with the actual class that I am testing. Instead I want to trigger the behavior by executing behavior that lies further outside. The behavior that triggers the behavior on the SUT may be an actual implementation, or it could be a fake.

The same applies to the result of the behavior that gets tested, instead of verifying some state in the SUT I want to verify what happens outside of the SUT. So what matters is that I test the behavior not the state of the subject under test.

I also try to get further away from the SUT then its immediate usage. Doing so makes the tests less brittle for change. This in itself is not always an easy task, but I recommend you try it anyway.

##The BaseTestFixture##

This is the simplest test fixture class that I have and I use this for and I actually don’t use this anywhere in the example code, but it serves a really good basic overview of the semantics that are shared among the other test fixture classes.

<script src="http://gist.github.com/507143.js?file=1.cs"></script>

It is following the Given When Then (GWT) approach, and as you can see it is really simple. Also note that I introduced some other named attributes by simply inheriting from the default NUnit attributes, this was purely done to stay with the GWT approach.

Below here is an incredible KISS example of how you would use this BaseTestFixture, which I believe doesn’t need further explanation. (I know I am misusing the term KISS here, but I thought if was fitting anyway).

<script src="http://gist.github.com/507143.js?file=2.cs"></script>

##The BaseTestFixture<TSubjectUnderTest>##

Now we are getting into a more interesting case because now my subject under test is actually provided by the generic parameter of the base test fixture class. And to be honest this class is only used with 12 specifications out of the 122 specification classes. This is mostly because it is still a very generic solution, but again a nice way to ease into it.

<script src="http://gist.github.com/507143.js?file=3.cs"></script>

Wow there is _a lot_ more going on here! You are right, because here I make the base test fixture responsible for instantiating the subject under test, including providing mocks for any dependencies that it may have. So it is an auto mocker as well, but the interesting part here is that it puts a reference of the injected mocks in a collection that you can access inside your tests by using the OnDependency<TType> method that returns a Moq object.

Take a look at a specification using this base test fixture class:

<script src="http://gist.github.com/507143.js?file=4.cs"></script>

So the first thing you see is the method SetupDependencies that is requesting the mock object for injected type IReporintgRepository and it is using the Moq way of setting up the Mock object. This is only needed when in your specification you need the mocks to be setup in a specific way. I intentionally separated the SetupDependencies from the Given as they may be two different things. And in the actual test you see the usage of the OnDependency method again where its being used to verify that something was indeed triggered on the injected class.

Now indeed this is not really treating the subject under test as a black box, for example in the When I make a direct call to a method on the subject under test. So my test knows about this now, meaning when it changes I need to change this test as well. So lets take a look where I go a bit further into the black box mentality.

##The PresenterTestFixture<TPresenter>##

Here I am not going to show you the code of the PresenterTestFixture implementation as it is almost identical the the previous base test fixture. So lets go straight to an actual specification:

<script src="http://gist.github.com/507143.js?file=5.cs"></script>

Again there is the setting up of a dependency in the beginning and then there is the Given method, Presenter in this case is the subject under test, so you can see that the specification still knows about the SUT in the Given, but you will notice that this is not used in either the When or the Then.

Hey what is that On thing in there? Well that is a very small DSL wrapping the Moq API. I did this to make it slightly more readable, and in this case it is very adapt towards working with a view and presenter. In the Given I am setting up my IClientDetailsView with the correct data, but I am also simulating that an event was triggered. This is not logic that the test is concerned about, all we do here is bring the view and the presenter in the correct state for this particular specification. So instead of setting these things directly on the presenter this will all be directed from the view.

Then in the When we again fire an event from the view, but in this case it is the going to trigger the behavior on the presenter that we want to verify. And in the Then methods we verify on the view again that the presenter actually did the correct things, but we also verify on other dependencies that the correct methods where called, in this case the IBus.

I am not completely happy with the mini DSL yet, but I think it is cleaner then the default Moq API. Just for those that are curious, here is the mini DSL which gets returned by the On method:

<script src="http://gist.github.com/507143.js?file=6.cs"></script>

##CQRS and Event Sourcing##

By combining [CQRS and Event Sourcing](http://elegantcode.com/2009/11/11/cqrs-la-greg-young/) we get an architecture that is very suitable for black box testing its behavior, which was a real eye opener when Greg demonstrated this to me. He says that the way to bring your aggregate root back into the desired state is to playback the events that are needed to do so. Then you can execute the behavior on the aggregate root, and finally to actually verify your behavior you retrieve the published events and verify that they are as expected.

Now the beauty of this is that the setup and the verification this will work on any aggregate root because we are using the IEventProvider interface there that they all implement. The only actual knowledge about the aggregate root that remains is the specific behavior that you trigger.

But I went a little bit further then what was shown during the course, I am saying that instead of executing the behavior on the aggregate root we could also just provide the command that should trigger this behavior to be executed. Because the command would be handled by a specific command handler which in turn would execute the domain behavior.

Now below here is the command test fixture that allows me to do just that, I need to provide the actual command, command handler and aggregate root types that are to be used in this specification.

<script src="http://gist.github.com/507143.js?file=7.cs"></script>

Please note that the Given method now returns an IEnumerable<IDomainEvent> this is to be used to provide the events that are needed to bring the aggregate root into the correct state for this specification. This is using the exact same mechanism as the actual code uses to make state changes in the aggregate root, so there cannot be a case that you are testing your aggregate root using a state that it cannot get into.

The When method returns the expected command, so all you do there is create the command with the correct information and return it to the specification.

Then in the try catch block you may have noticed that a command handler is executing the provided command and that after that the events are being retrieved from the aggregate root. These events are what you would verify to make sure your domain behavior is correct.

But this may all sound very abstract, lets look at a simple specification and see how clean and readable is really is:

<script src="http://gist.github.com/507143.js?file=8.cs"></script>

So you provide historical events to bring the aggregate root into the expected state, you fire of the command, then you verify the published events to ensure your domain behavior is correct. If you choose the correct naming for your events and commands, then a business person would be able to understand the specification. Especially if you parse the text and do a little bit of formatting.

##Where is Should?##

Hey what are all those WillBe and WillBeOfType things that I see in your specifications, should they not be ShouldBe and ShouldBeOfType? Well I used to think so as well, until I attended a presentation by [Kevlin Henney at NDC](http://arkiv.ndc2009.no/agenda.aspx?cat=1071&id=1813&day=3728) where he explained that Should is not specific enough. Should indicates that it might not. I like to use the example; “I should really do the dishes, but I won’t”. By using Will Be and Must you are much more dictating what will or must happen, its not a question anymore.

##Finally##

I am completely taken by this approach and as you see you don’t need a big BDD framework for this. I think using something like this gives a good learning experience before going towards an actual BDD framework like [MSpec](http://codebetter.com/blogs/aaron.jensen/archive/2008/05/08/introducing-machine-specifications-or-mspec-for-short.aspx). Also Uncle Bob just wrote a good post about to [not abuse the Given When Then approach](http://blog.objectmentor.com/articles/2009/12/19/the-polyglot-tester) and also take a look at the [Mocks aren’t Stubs](http://martinfowler.com/articles/mocksArentStubs.html) article by Martin Fowler.

By now you must <grin> understand that I like to throw with code examples so yes the post is very long, but I hope it provides enough value instead of just confusion.