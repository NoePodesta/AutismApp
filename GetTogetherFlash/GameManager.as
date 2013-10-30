package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	public class GameManager extends MovieClip {

		
		var gameView : GameView;
		var mainManager : Main;
		
		var channel:SoundChannel;
		var gameJingle : Sound; 
		
		var winGameScreen : MovieClip;
		
		var totalLoaded : int;
		var totalOptions : int;
		
		var gameType : String;
		var gameContent : Object;
		

		
		public function GameManager(mainManager : Main, gameType : String, gameContent : Object){
			this.mainManager = mainManager;
			this.gameType = gameType;
			this.gameContent = gameContent;
			
			
			
			
			gameJingle = new PlayingJingle();
			winGameScreen = new winScreen_mc;
			winGameScreen.y = 68;
			winGameScreen.x = 1024/2 - 465.95/2;
			winGameScreen.winScreenGoBack_mc.addEventListener(TouchEvent.TOUCH_TAP, destroyGame);
			
			channel = new SoundChannel();
			
			
	
			// constructor code
		}
		
		public function closeView():void{
			removeChild(gameView);
			mainManager.goToGameTypeSelectionScreen();
		}		
		
		
		
		public function endGame(){
			addChild(winGameScreen);
			
		}
		
		function loopJingle(e:Event):void
		{
			 channel = gameJingle.play();
			 channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);

		}
		
		public function changeMusicState(playingMusic : Boolean):void
		{
			if(playingMusic){
				channel.stop();
				playingMusic = false;
			}else{
				channel = gameJingle.play();
				channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);
				playingMusic = true;
			}
		}

		function onLoadComplete():void{
			addChild(gameView);
			mainManager.showGameView(this);
		}
		
		public function destroyGame(e : TouchEvent) : void{
			channel.stop();
			channel = null;
			mainManager.destroyGame();
			
		}	
		
	
		
		public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					trace("Correcto");
					//right.play();					
					endGame();
				}else{
					answer.resetPosition();
					//wrong.play();
				}
				
			}
		}
		
		 public function loadImageComplete() : void{
			
			
		}
		
		public function onOptionLoadComplete():void{
			
		}
		
		
		
	}
	
}
