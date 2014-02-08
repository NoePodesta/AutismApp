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
			
			if(gameType == GameType.CLASSIFICATION) {
				background = new ClassificationView;
			}else if(gameType == GameType.CONVERSATION){
				background = new ConversationView;			
			}else if(gameType == GameType.SOCOCO){
				background = new SoCoCoView;
			}else if( gameType == GameType.SOUND){
				background = new SoundsView;
			}else if(gameType == GameType.QA){
				background = new QAView;
			}else if(gameType == GameType.SENTENCE){
				background = new SentenceView;
			}
			addChild(background);
			setEventListeners();
		
		}
		
		function setEventListeners() : void{
			background.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN,goBack);
			background.stopMusic_mc.addEventListener(TouchEvent.TOUCH_BEGIN,changeMusicState);
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.destroyGame(null);
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
