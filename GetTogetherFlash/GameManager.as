package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	public class GameManager extends MovieClip {

		
		var gameView : GameView;
		var mainManager : Main;	
		
		var winGameScreen : MovieClip;
		
		var totalLoaded : int;
		var totalOptions : int;
		
		var gameType : String;
		var gameContent : Object;
		

		var resultColector : ResultColector;
		
		var totalStages : int;
		
		public function GameManager(mainManager : Main, gameType : String, gameContent : Object){
			this.mainManager = mainManager;
			this.gameType = gameType;
			this.gameContent = gameContent;		
			this.totalStages = gameContent.totalStages;
			resultColector = new ResultColector(gameType,0,0,0);
			winGameScreen = new winScreen_mc;
			winGameScreen.y = 68;
			winGameScreen.x = 1024/2 - 465.95/2;
			winGameScreen.winScreenGoBack_mc.addEventListener(TouchEvent.TOUCH_TAP, destroyGame);
			if((mainManager.therapist != null && mainManager.selectedPatient != -1) || mainManager.offlineMode){
				winGameScreen.sendResults_mc.addEventListener(TouchEvent.TOUCH_TAP, sendResults);
			}else{
				winGameScreen.sendResults_mc.alpha = 0.5;
			}
			
		}
		
	
		
		public function endGame(){
			SoundManager.playVictorySound();
			addChild(winGameScreen);			
		}
		
		
		
		public function changeMusicState(playingMusic : Boolean):void
		{
			if(playingMusic){
				SoundManager.stopGameJingle();
			}else{
				SoundManager.playGameJingle();
			}
		}

		function onLoadComplete():void{
			addChild(gameView);
			SoundManager.playGameJingle();
			mainManager.showGameView(this);
		}
		
		public function destroyGame(e : TouchEvent) : void{			
			SoundManager.stopGameJingle();
			mainManager.destroyGame();
			
		}	
		
	
		
		public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			/*
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					SoundManager.playCorrectSound();					
					endGame();
				}else{
					SoundManager.playWrongSound();
					answer.resetPosition();
				}				
			*/
		}
		
		 public function loadImageComplete() : void{
			
			
		}
		
		public function onOptionLoadComplete():void{
			
		}
		
		protected function playCorrectSound():void{
			SoundManager.playCorrectSound();
		}
		
		protected function playVictorySound():void{
			SoundManager.playVictorySound();
		}
		
		protected function playWrongSound():void{
			SoundManager.playWrongSound();
		}
		
		public function sendResults(e : Event):void{
			mainManager.sendResults(gameType, resultColector);
		}
		
		
		
	}
	
}
