package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.events.Event;
    import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.ui.Keyboard;
	


	
	public class Main extends MovieClip {

		var mainScreen : MovieClip;
		var gameTypeSelectionScreen : MovieClip;
		var cardsSelectionScreen : MovieClip;
		var httpManager : HTTPManager;
		
		var emotionSubSelectionScreen : SubSelectionGameScreen;
		var communicationSubSelectionScreen : SubSelectionGameScreen;
		var cognitionSubSelectioScreen : SubSelectionGameScreen;
		var loadingScreen : MovieClip;
		
		var loadedSubSelectionScreen : SubSelectionGameScreen;
		var currentGame : GameManager;
		var cardsManager : CardManager;
		
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;				
			//Initialize Views			
			mainScreen = new mainScreen_mc();
			cardsSelectionScreen = new cardsSelectionScreen_mc;
			gameTypeSelectionScreen = new gameSelectionScreen_mc;
			emotionSubSelectionScreen = new EmotionSubSelectionScreen(this);
			communicationSubSelectionScreen = new CommunicationSubSelectionScreen(this);
			cognitionSubSelectioScreen = new CognitionSubSelectionScreen(this);
			loadingScreen = new loadingScreen_mc;
			addChild(mainScreen);
			//Initialize Managers
			
			httpManager = new HTTPManager();
			//Initialize events
			mainScreen.initializeApplicationButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToGameSelectionScreenEvent);
			mainScreen.initializeCardsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCardsSelectionScreenEvent);
			mainScreen.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
			gameTypeSelectionScreen.emotionsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToEmotionsSelectionScreen);
			gameTypeSelectionScreen.cognitionButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCognitionSelectionScreen);
			gameTypeSelectionScreen.communicationsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCommunicationsSelectionScreen);
			cardsSelectionScreen.initializeCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP, loadCards);
			/*
			mainScreen.username_txt.addEventListener( Event.CHANGE, onTFChange );
            mainScreen.username_txt.addEventListener( SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, softKeyboardEvent );
            mainScreen.username_txt.addEventListener( SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, softKeyboardEvent );
			*/
		}
		
		public function goToGameSelectionScreenEvent(e : TouchEvent) : void{
			removeChild(mainScreen);
			goToGameTypeSelectionScreen();
			
		}	
		
		public function goToCardsSelectionScreenEvent(e : TouchEvent) : void{
			removeChild(mainScreen);
			goToCardSelectionScreen();
			
		}		
	
		function goToEmotionsSelectionScreen(e : TouchEvent){
			loadedSubSelectionScreen = emotionSubSelectionScreen;
			removeChild(gameTypeSelectionScreen);
			addChild(loadedSubSelectionScreen);
		}
		
		function goToCommunicationsSelectionScreen(e : TouchEvent){
			loadedSubSelectionScreen = communicationSubSelectionScreen;
			removeChild(gameTypeSelectionScreen);
			addChild(loadedSubSelectionScreen);
		}
		
		function goToCognitionSelectionScreen(e : TouchEvent){
			loadedSubSelectionScreen = cognitionSubSelectioScreen;
			removeChild(gameTypeSelectionScreen);
			addChild(loadedSubSelectionScreen);
		}
		
		public function goToGameTypeSelectionScreen(){
			gameTypeSelectionScreen.gotoAndPlay(0);
			addChild(gameTypeSelectionScreen);	
		}
		
		public function goToCardSelectionScreen(){
			addChild(cardsSelectionScreen);	
		}
		
		
		public function loadCards(e : TouchEvent) : void{
			cardsManager = new CardManager(this, 5);
			addChildAt(loadingScreen, 1);
			cardsManager.loadCards();
		}
		
		public function closeCardGame() : void{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;	
			removeChild(cardsManager);
			cardsManager = null;
			addChild(mainScreen);
		}
		
		
		public function goBackToGameType(subSelectionGameScreen : SubSelectionGameScreen) : void{
			removeChild(subSelectionGameScreen);
			gameTypeSelectionScreen.gotoAndPlay(0);
			addChild(gameTypeSelectionScreen);
		}
		
		public function startGame(subSelectionGameScreen : SubSelectionGameScreen, selection : int){
			addChildAt(loadingScreen, 1);
			if(subSelectionGameScreen is EmotionSubSelectionScreen){
				if(selection == 0){
					currentGame = new EmotionGameManager(this);
				}else if(selection == 1){
					currentGame = new EmotionsFaceGameManager(this);
				}else if(selection == 2){
					currentGame = new EmotionStoryGameManager(this);
				}
			}else if(subSelectionGameScreen is CognitionSubSelectionScreen){
				if(selection == 0){
					currentGame = new CognititionUseGameManager(this);
				}
			}else{
				if (selection == 0){
					currentGame = new CommunicationsSignsGameManager(this);
				}
			}
			
			
			
		
		}
		
		public function showGameView(gameManager : GameManager){
			removeChild(loadingScreen);
			removeChild(loadedSubSelectionScreen);
			addChild(gameManager);
		}
		
		public function destroyGame(){
			removeChild(currentGame);
			currentGame = null;
			goToGameTypeSelectionScreen();
		}
		
		public function startCardGame() : void{
			removeChild(cardsSelectionScreen);
			removeChild(loadingScreen);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			addChild(cardsManager);
		}
			
		
		//IOS AND HTTP NEEDS
		public function testConnection(e : TouchEvent):void{
			httpManager.testConnection();
		}
		
		public function testLogin(e : TouchEvent):void{
			httpManager.testLogin(mainScreen.username_txt.text, mainScreen.password_txt.text);
		}
		
		
		
		
		
		private function showKeyboard( event:Event ):void{
            trace("show");
            mainScreen.username_txt.requestSoftKeyboard();
        }
		
        private function hideKeyboard( event:Event ):void{
            trace("hide");
            this.stage.focus = null;
        }
		
        private function onTFChange( event:Event ):void{
            trace("Character typed: " + mainScreen.username_txt.text.charAt( mainScreen.username_txt.text.length - 1 ) );
            //mainScreen.username_txt.text = "";
        }    
		
        private function softKeyboardEvent( event:SoftKeyboardEvent ):void{
            trace( this.stage.softKeyboardRect );
        }

	
	}
}