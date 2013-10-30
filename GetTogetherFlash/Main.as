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
			
			
			jLoader = new JSONLoader(this);
			/*
			var QAJson:Object = new Object();
			var graphicOptions : Array = new Array({graphicOption:"SignsImages/thumbsUp.png",classificationGroup:0,quantity:1},
													{graphicOption:"ElementsImages/hammer.png",classificationGroup:1,quantity:3},
													{graphicOption:"ShapesImages/reptiloide.png",classificationGroup:2,quantity:4});
			var answerAreas : Array = new Array({textOption:"Manos",classificationGroup:0},
													{textOption:"Martillo",classificationGroup:1},
													{textOption:"Reptiloide",classificationGroup:2});
													
			var textOption : Array = new Array({textOption:"Manos",classificationGroup:0},
												{textOption:"Martillo",classificationGroup:1},
												{textOption:"Reptiloide",classificationGroup:2});
										 
			QAJson.graphicOptions = graphicOptions;
			QAJson.answerAreas = answerAreas;
			QAJson.textOption = textOption;
			
				

			trace(jLoader.parseJSON(QAJson));
		
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
		
		public function startGame(subSelectionGameScreen : SubSelectionGameScreen, selection : int){
			addChildAt(loadingScreen, 1);
			if(subSelectionGameScreen is EmotionSubSelectionScreen){
				if(selection == 0){
					jLoader.getJSON("JSONs/EmotionSplitFaceGIFQA.txt");	
					currentGameCategory = "QA";
				}else if(selection == 1){
					jLoader.getJSON("JSONs/EmotionFaceQA.txt");
					currentGameCategory = "QA";
				}else if(selection == 2){
					jLoader.getJSON("JSONs/EmotionStoryQA.txt");
					currentGameCategory = "QA";					
				}
				currentGameType = GameType.Emotions;
			}else if(subSelectionGameScreen is CognitionSubSelectionScreen){
				if(selection == 0){
					jLoader.getJSON("JSONs/CognitionSentence.txt");
					currentGameCategory = "Sentence";
				}else if(selection == 1){
					jLoader.getJSON("JSONs/CognitionSoCoCo.txt");
					currentGameCategory = "SoCoCo";
				}else if(selection == 2){
					jLoader.getJSON("JSONs/CognitionUseClassification.txt");
					currentGameCategory = "Classification";
				}
				currentGameType = GameType.Cognition;
			}else{
				if (selection == 0){
					jLoader.getJSON("JSONs/CognitionUseClassification.txt");
					currentGameCategory = "Classification";
				}else if(selection == 1){
					jLoader.getJSON("JSONs/CommunicationsConversation.txt");
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