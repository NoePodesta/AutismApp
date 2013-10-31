package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	
	public class GameView  extends MovieClip {

	
		var background : MovieClip;
		var manager : GameManager;
		var playingMusic : Boolean;
		
		
		
		public function GameView(manager : GameManager, gameType : String){
			this.manager = manager;
			playingMusic = true;
			
			if(gameType == GameType.Cognition){
				background = new cognitionGameView_mc();
			}else if(gameType == GameType.Emotions){
				background = new emotionGameView_mc();
			}else if(gameType == GameType.Communications){
				background = new communicationsGameView_mc();
			}
			addChild(background);
			setEventListeners();
		
		}
		
		function setEventListeners() : void{
			background.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN,goBack);
			background.stopMusic_mc.addEventListener(TouchEvent.TOUCH_BEGIN,changeMusicState);
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.closeView();
		}
		
		public function changeMusicState(e : TouchEvent) : void{
			manager.changeMusicState(playingMusic);
			if(playingMusic){
				background.stopMusic_mc.gotoAndStop(2);
				playingMusic = false;
			}else{
				background.stopMusic_mc.gotoAndStop(1);
				playingMusic = true;
			}
			
			
		}
		
	
	
	}
	
}
