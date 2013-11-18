package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Multitouch;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.geom.Rectangle;
	
	
	public class CardManager extends MovieClip {

	
		var totalCards : Number;
		
		var mainManager : Main;
		
		var totalLoadedCards : int;
		
		var finalScreen : MovieClip;
		
		var finalCardScreen : MovieClip;
		
		var cardsArray : Array;
		
		var currentCard : int;
		var currX:Number;
		var cardsContent : Object;
		
		public function CardManager(mainManager: Main,cardsContent : Object) {
			this.cardsContent = cardsContent;
			this.totalCards = cardsContent.totalCards;
			this.mainManager = mainManager;
			cardsArray = new Array(totalCards);
			finalCardScreen = new finalCardScreen_mc;
			finalCardScreen.closeCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP,closeCardGame);
			finalCardScreen.restartCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP,restartCardGame);
			totalLoadedCards = 0;
			currentCard = 0;
			currX = 0;
			
			addEventListener(Event.ENTER_FRAME, loop);
			
			loadCards();
			
		}
		
		function loop(e:Event):void{
			currX += (currentCard*1024 - currX) * 0.15;
			scrollRect = new Rectangle(currX, 0, 1024, 768);
		}
		
		public function loadCardComplete() : void{
			totalLoadedCards++;
			if(totalLoadedCards == totalCards){
				loadCardsComplete();
			}
		}
		
		public function loadCardsComplete() : void{
			createMovieClipsSlides();
			addEventListener(TransformGestureEvent.GESTURE_SWIPE , onSwipe);
			mainManager.startCardGame();
			
			
			//cardsContainer.width = totalCards * 1024 * 2;
			//createMovieClipSlides();
			//showCard(0);
		}
		
		function createMovieClipsSlides() : void{
			for( var i:int = 0; i<totalCards;i++){
				addChild(cardsArray[i]);
				cardsArray[i].x = 1024 * i;				
			}	
			finalCardScreen.x = 1024 * totalCards;
			addChild(finalCardScreen);
		}
		
	
		
		public function loadCards():void{
			for(var i : int=0;i<totalCards; i++){
				cardsArray[i] = new CardView(this,cardsContent.cards[i].imageURL,cardsContent.cards[i].imageName);
			}
			
		}
		/*
		function showCard(cardIndex : int):void{
			addChild(cardsArray[cardIndex]);
		}
		
		function showNextCard():void{
			removeChild(cardsArray[currentCard]);
			if(currentCard == totalCards - 1){
				showFinalScreen();
			}else{
				currentCard++;
				addChild(cardsArray[currentCard]);
			}
		}
		
		
		function showPreviousCard():void{
			if(!currentCard == 0){
				removeChild(cardsArray[currentCard]);
				currentCard--;
				addChild(cardsArray[currentCard]);
			}
		}
		*/
		
		
		function showFinalScreen():void{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;	
			//addChild(finalCardScreen);
		}
		
		function restart(): void{
			x = 0;
			currentCard = 0;
		}
		
		
		function closeCardGame(e : TouchEvent):void{
			mainManager.closeCardGame();
		}
		
		function restartCardGame(e : Event):void{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			restart();
		}
		
		function onSwipe (e:TransformGestureEvent):void{
			if(e.offsetX == 1 && currentCard > 0){
				currentCard--;
			}
			if(e.offsetX == -1){
				if(currentCard < totalCards - 1){
					currentCard++;
				}else{
					currentCard++;
					showFinalScreen();
				}
			}
			/*
			if (e.offsetX == -1) { 
				showNextCard();
			}else if (e.offsetX == 1) { 
				showPreviousCard();
			} 
			*/
		}

	}
	
}
