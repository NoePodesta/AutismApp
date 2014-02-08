package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.events.Event;
    import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.ui.Keyboard;
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	


	
	public class Main extends MovieClip {

		var mainScreen : MovieClip;
		var gameTypeSelectionScreen : MovieClip;
		var httpManager : HTTPManager;
		
		var loadingScreen : MovieClip;
		
		var currentGame : GameManager;
		var cardsManager : CardManager;
		
		var currentGameType : String;	
		
		var jLoader : JSONLoader;
		
		var topBar : TopBarView;
		
		var therapist : Therapist;
		
		public var selectedPatient : int;
		
		var patientsComboBox : ComboBox;
		
		var packageSelectionScreen : PackageSelectionScreen;
		
		var bitacoraManager : BitacoraManager;
		
		var offlineMode : Boolean;
		
		var saveManager : SaveManager;
		var offlineRecordScreen : OfflineRecordScreenManager;

		
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;				
			
			//Initialize Managers		
			jLoader = new JSONLoader(this);	
			httpManager = new HTTPManager(this, jLoader);
			saveManager = new SaveManager(this);
			
			//Initialize Views	
			topBar = new TopBarView(this, httpManager);
			mainScreen = new mainScreen_mc();
			gameTypeSelectionScreen = new gameSelectionScreenW_mc;
			packageSelectionScreen = new PackageSelectionScreen(this);
			loadingScreen = new loadingScreen_mc;
			
			//Initialize events
			mainScreen.initializeApplicationButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToGameSelectionScreenEvent);
			mainScreen.initializeCardsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToCardsSelectionScreenEvent);
			
			gameTypeSelectionScreen.conversationButton_mc.addEventListener(TouchEvent.TOUCH_TAP, conversationSelected);
			gameTypeSelectionScreen.qaButton_mc.addEventListener(TouchEvent.TOUCH_TAP, qaSelected);
			gameTypeSelectionScreen.classificationButton_mc.addEventListener(TouchEvent.TOUCH_TAP, classificationSelected);
			gameTypeSelectionScreen.soCoCoButton_mc.addEventListener(TouchEvent.TOUCH_TAP, soCoCoSelected);
			gameTypeSelectionScreen.sentenceButton_mc.addEventListener(TouchEvent.TOUCH_TAP, sentenceSelected);
			gameTypeSelectionScreen.soundButton_mc.addEventListener(TouchEvent.TOUCH_TAP, soundSelected);
			gameTypeSelectionScreen.goBackButton_mc.addEventListener(TouchEvent.TOUCH_TAP, goBackToMainScreen);


				
			addChild(mainScreen);
			addChildAt(topBar,1);
			
			
										  
			
			
		}
		
		
		
		public function getTherapistPackages(packages : Array):void{
			if(therapist != null){
				for(var i : int = 0;i<therapist.packages.length;i++){
					if(therapist.packages[i].packageType == currentGameType){
						packages.push(new PackageOption(therapist.packages[i].packageName, therapist.packages[i].packageUrl)); 
					}
				}	
			}
			
		}
		
		public function getCardsPackages():Array{
			var cardsPackages : Array = new Array();
			cardsPackages.push(new PackageOption("Cartas Default", "JSONs/Cards.txt"));
			getTherapistPackages(cardsPackages);
			return cardsPackages;
		}
		
		public function getQAPackages():Array{
			var qaPackages : Array = new Array();
			qaPackages.push(new PackageOption("Emociones Default", "JSONs/EmotionFaceQA.txt"));
			getTherapistPackages(qaPackages);
			return qaPackages;
		}
		
		public function getClassificationPackages():Array{
			var classificationPackages : Array = new Array();
			classificationPackages.push(new PackageOption("Clasificacion Default", "JSONs/CognitionUseClassification.txt"));
			getTherapistPackages(classificationPackages);
			return classificationPackages;
		}
		
		public function getSoCoCoPackages():Array{
			var soCoCoPackages : Array = new Array();
			soCoCoPackages.push(new PackageOption("SoCoCo Default", "JSONs/CognitionSoCoCo.txt"));
			getTherapistPackages(soCoCoPackages);
			return soCoCoPackages;
		}
		
		public function getSentencePackages():Array{
			var sentencePackages : Array = new Array();
			sentencePackages.push(new PackageOption("Oracion Default", "JSONs/Sentence.txt"));
			sentencePackages.push(new PackageOption("Oracion JSON", "JSONs/SentenceJSON.txt"));			
			
			getTherapistPackages(sentencePackages);
			return sentencePackages;
		}
		
		public function getConversationPackages():Array{
			var conversationPackages : Array = new Array();
			conversationPackages.push(new PackageOption("Conversacion Default", "JSONs/CommunicationsConversation.txt"));
			getTherapistPackages(conversationPackages);
			return conversationPackages;
		}
		
		public function getSoundPackages():Array{
			var conversationPackages : Array = new Array();
			conversationPackages.push(new PackageOption("Sonidos Default", "JSONs/SoundQA.txt"));
			getTherapistPackages(conversationPackages);
			return conversationPackages;
		}
		
		public function goToGameSelectionScreenEvent(e : TouchEvent) : void{
			removeChild(mainScreen);
			goToGameTypeSelectionScreen();
			
		}	
		
		public function conversationSelected(e : TouchEvent): void{
			currentGameType = GameType.CONVERSATION;
			packageSelectionScreen.setPackages(getConversationPackages());
			goToPackagesSelectionScreen();
		}
		
		public function qaSelected(e : TouchEvent): void{
			currentGameType = GameType.QA;
			packageSelectionScreen.setPackages(getQAPackages());
			goToPackagesSelectionScreen();
		}
		
		public function classificationSelected(e : TouchEvent): void{
			currentGameType = GameType.CLASSIFICATION;
			packageSelectionScreen.setPackages(getClassificationPackages());
			goToPackagesSelectionScreen();
		}
		
		public function soCoCoSelected(e : TouchEvent): void{
			currentGameType = GameType.SOCOCO;
			packageSelectionScreen.setPackages(getSoCoCoPackages());
			goToPackagesSelectionScreen();
		}
		
		public function sentenceSelected(e : TouchEvent): void{
			currentGameType = GameType.SENTENCE;
			packageSelectionScreen.setPackages(getSentencePackages());
			goToPackagesSelectionScreen();
		}
		
		public function soundSelected(e : TouchEvent): void{
			currentGameType = GameType.SOUND;
			packageSelectionScreen.setPackages(getSoundPackages());
			goToPackagesSelectionScreen();
		}
		
		function goToPackagesSelectionScreen():void{
			removeChild(gameTypeSelectionScreen);
			addChildAt(packageSelectionScreen,0);
		}
		
		public function goToCardsSelectionScreenEvent(e : TouchEvent) : void{			
			currentGameType = GameType.CARDS;
			packageSelectionScreen.setPackages(getCardsPackages());
			removeChild(mainScreen);
			addChildAt(packageSelectionScreen,0);			
		}		
	
		
		
		public function goToGameTypeSelectionScreen(){
			gameTypeSelectionScreen.gotoAndPlay(0);
			addChildAt(gameTypeSelectionScreen,0);	
		}		
		
		
		public function loadCards(gameContent : Object) : void{
			
			addChildAt(loadingScreen, 2);
			cardsManager.loadCards();
		}
		
		public function closeCardGame() : void{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;	
			removeChild(cardsManager);
			cardsManager = null;
			addChildAt(mainScreen,0);
		}
		
		
		public function goBackToGameType() : void{
			removeChild(packageSelectionScreen);
			gameTypeSelectionScreen.gotoAndPlay(0);
			addChildAt(gameTypeSelectionScreen,0);
		}
		
		public function loadGame(gameContent : Object):void{
			if(currentGameType == GameType.QA){
				currentGame = new QAGameManager(this,gameContent,currentGameType);
			}else if(currentGameType == GameType.CLASSIFICATION){
				currentGame = new ClassificationGameManager(this,gameContent,2,currentGameType);	
			}else if(currentGameType == GameType.SENTENCE){
				currentGame = new SentenceGameManager(this,gameContent,currentGameType);
			}else if(currentGameType == GameType.CONVERSATION){
				currentGame = new ConversationGameManager(this,gameContent,currentGameType);
			}else if(currentGameType == GameType.SOCOCO){
				currentGame = new SoCoCoGameManager(this,gameContent,currentGameType);
			}else if(currentGameType == GameType.SOUND){
				currentGame = new SoundQAManager(this,gameContent,currentGameType);
			}else if(currentGameType == GameType.CARDS){
				cardsManager = new CardManager(this, gameContent);
				loadCards(gameContent);
			}
			
		}
		
		public function startGame(url : String){
			addChildAt(loadingScreen, 2);
			jLoader.getJSON(url);
		}
		
		public function showGameView(gameManager : GameManager){
			removeChild(loadingScreen);
			removeChild(packageSelectionScreen);
			removeChild(topBar);
			addChild(gameManager);
		}
		
		public function destroyGame(){
			removeChild(currentGame);
			addChild(topBar);
			currentGame = null;
			goToGameTypeSelectionScreen();
		}
		
		public function startCardGame() : void{
			removeChild(packageSelectionScreen);
			removeChild(loadingScreen);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			addChild(cardsManager);
		}
		
		public function createTherapist(therapistJSON : Object){
			therapist = new Therapist(therapistJSON.id, therapistJSON.name, therapistJSON.surname, therapistJSON.patients,therapistJSON.patientsId, therapistJSON.packages, therapistJSON.dni);
			if(therapistJSON.patientsId.length != 0){
				selectedPatient = therapistJSON.patientsId[0];
			}else{
				selectedPatient = -1;
			}
			topBar.loggedIn(therapist.therapistName + " " + therapist.surname);
			topBar.setPatients(therapistJSON.patients);	
			var offlineRecords : Array = saveManager.getOfflineResults(therapistJSON.dni);
			if(offlineRecords.length != 0){
				offlineRecordScreen = new OfflineRecordScreenManager(offlineRecords, this);			
				addChild(offlineRecordScreen);	
				//stage.focus = offlineRecordScreen;
			}
			offlineMode = false;
		}
		
		public function changeSelectedPatient(selectedIndex : int):void{
			selectedPatient = therapist.patientsId[selectedIndex];
		}
		
		public function sendOfflineRecords():void{
			saveManager.removeOfflineRecords(therapist.dni);
			removeChild(offlineRecordScreen);
		}
		
		public function sendResults(gameType : String, resultColector : ResultColector){
			if(offlineMode){
				saveManager.addLocalResult(gameType, resultColector, topBar.getOfflineDNI(), topBar.getOfflinePatient());
			}else{
				if(selectedPatient != -1){
					httpManager.sendResults(gameType, resultColector, therapist.id, selectedPatient);
				}else{
					trace("No has elegido a ningun paciente");
				}		
			}				
		}
		
		public function logoutTherapist():void{
			therapist = null;
		}
		
		public function startBitacoraScreen():void{
			removeChildAt(0);
			bitacoraManager = new BitacoraManager(this);
			addChildAt(bitacoraManager, 0);
		}
		
		public function goBackToMainScreen(e : Event):void{
			removeChildAt(0);
			addChildAt(mainScreen,0);
		}
		
		public function sendBitacora(bitacora : String):void{
			//TODO
			trace(bitacora);
			goBackToMainScreen(null);
		}
		
		public function startOfflineMode():void{
			offlineMode = true;
		}
		
	

	
	}
}