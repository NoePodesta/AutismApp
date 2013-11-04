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
		
		var currentGameType : String;
		var currentGameCategory : String;
		
		var jLoader : JSONLoader;
		
		var topBar : TopBarView;
		
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;				
			
			//Initialize Managers		
			jLoader = new JSONLoader(this);	
			httpManager = new HTTPManager(this, jLoader);
			
			
			//Initialize Views	
			topBar = new TopBarView(httpManager);
			mainScreen = new mainScreen_mc();
			cardsSelectionScreen = new cardsSelectionScreen_mc;
			gameTypeSelectionScreen = new gameSelectionScreen_mc;
			emotionSubSelectionScreen = new EmotionSubSelectionScreen(this, buildDefaultEmotionsPackages());
			communicationSubSelectionScreen = new CommunicationSubSelectionScreen(this,buildDefaultEmotionsPackages());
			cognitionSubSelectioScreen = new CognitionSubSelectionScreen(this,buildDefaultEmotionsPackages());
			loadingScreen = new loadingScreen_mc;
			
			//Initialize events
			mainScreen.initializeApplicationButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToGameSelectionScreenEvent);
			mainScreen.initializeCardsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCardsSelectionScreenEvent);
			gameTypeSelectionScreen.emotionsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToEmotionsSelectionScreen);
			gameTypeSelectionScreen.cognitionButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCognitionSelectionScreen);
			gameTypeSelectionScreen.communicationsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCommunicationsSelectionScreen);
			cardsSelectionScreen.initializeCardGame_mc.addEventListener(TouchEvent.TOUCH_TAP, loadCards);


			
			
			addChild(mainScreen);
			addChild(topBar);
			
	
		}
		
		public function buildDefaultEmotionsPackages():Array{
			var defaultEmotionsPackage : Array = new Array();
			defaultEmotionsPackage.push(new PackageOption("Emociones Default", "JSONs/EmotionFaceQA.txt"));
			return defaultEmotionsPackage;
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
		
		public function loadGame(gameContent : Object):void{
			if(currentGameCategory == "QA"){
				currentGame = new QAGameManager(this,gameContent,currentGameType);
			}else if(currentGameCategory == "Classification"){
				currentGame = new ClassificationGameManager(this,gameContent,2,currentGameType);	
			}else if(currentGameCategory == "Sentence"){
				currentGame = new SentenceGameManager(this,gameContent,currentGameType);
			}else if(currentGameCategory == "Conversation"){
				currentGame = new ConversationGameManager(this,gameContent,currentGameType);
			}else if(currentGameCategory == "SoCoCo"){
				currentGame = new SoCoCoGameManager(this,gameContent,currentGameType);
			}
			
		}
		
		public function startGame(subSelectionGameScreen : SubSelectionGameScreen, selection : int,url : String){
			addChildAt(loadingScreen, 1);
			if(subSelectionGameScreen is EmotionSubSelectionScreen){
				if(selection == 0){
					jLoader.getJSON(url);	
					currentGameCategory = "QA";
				}else if(selection == 1){
					jLoader.getJSON(url);
					currentGameCategory = "QA";
				}else if(selection == 2){
					jLoader.getJSON(url);
					currentGameCategory = "QA";					
				}
				currentGameType = GameType.Emotions;
			}else if(subSelectionGameScreen is CognitionSubSelectionScreen){
				if(selection == 0){
					jLoader.getJSON(url);
					currentGameCategory = "Sentence";
				}else if(selection == 1){
					jLoader.getJSON(url);
					currentGameCategory = "SoCoCo";
				}else if(selection == 2){
					jLoader.getJSON(url);
					currentGameCategory = "Classification";
				}
				currentGameType = GameType.Cognition;
			}else{
				if (selection == 0){
					jLoader.getJSON(url);
					currentGameCategory = "Classification";
				}else if(selection == 1){
					jLoader.getJSON(url);
					currentGameCategory = "Conversation";
				}
				currentGameType = GameType.Communications;
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
			
		


	
	}
}