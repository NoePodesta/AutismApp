package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Multitouch;
	
	public class CardManager extends MovieClip {

	
		var totalCards : Number;
		
		var mainManager : Main;
		
		var totalLoadedCards : int;
		
		var finalScreen : MovieClip;
		
		var finalCardScreen : MovieClip;
		
		var cardsArray : Array;
		
		var currentCard : int;
		
		public function CardManager(mainManager: Main,cardsAmount : int) {
			
			this.totalCards = cardsAmount;
			this.mainManager = mainManager;
			cardsArray = new Array(totalCards);
			finalCardScreen = new finalCardScreen_mc;
			finalCardScreen.closeCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP,closeCardGame);
			finalCardScreen.restartCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP,restartCardGame);
			totalLoadedCards = 0;
			currentCard = 0;
			
		}
		
		public function loadCardComplete() : void{
			totalLoadedCards++;
			if(totalLoadedCards == totalCards){
				loadCardsComplete();
			}
		}
		
		public function loadCardsComplete() : void{
			mainManager.startCardGame();
			showCard(0);
		}
		
		public function loadCards():void{
			var i : int;
			for(i=0;i<totalCards; i++){
				if(i%2 == 0){
					cardsArray[i] = new CardView(this,"ElementsImages/hammer.png","Martillo");
				}else{
					cardsArray[i] = new CardView(this,"SignsImages/thumbsUp.png","Bueno");
				}
				
				cardsArray[i].addEventListener(TransformGestureEvent.GESTURE_SWIPE , onSwipe);
			}
			
		}
		
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
		
		function showFinalScreen():void{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;	
			addChild(finalCardScreen);
		}
		
		function restart(): void{
			removeChild(finalCardScreen);
			currentCard = 0;
			addChild(cardsArray[currentCard]);
		}
		
		function showPreviousCard():void{
			if(!currentCard == 0){
				removeChild(cardsArray[currentCard]);
				currentCard--;
				addChild(cardsArray[currentCard]);
			}
		}
		
		function closeCardGame(e : TouchEvent):void{
			mainManager.closeCardGame();
		}
		
		function restartCardGame(e : Event):void{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			restart();
		}
		
		function onSwipe (e:TransformGestureEvent):void{
			if (e.offsetX == 1) { 
				showNextCard();
			}
			if (e.offsetX == -1) { 
				showPreviousCard();
			} 
			
		}

	}
	
}
