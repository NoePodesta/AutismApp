package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	
	public class GameView  extends MovieClip {

	
		var background : MovieClip;
		var manager : GameManager;
		var playingMusic : Boolean;
		
		var answerGraphicArea : MovieClip ;
		
		public function GameView(manager : GameManager){
			this.manager = manager;
			playingMusic = true;
			
		
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
		
		public function getAnswerBoundaries() : Rectangle{
			return answerGraphicArea.getRect(this) as Rectangle;
		}
	
	}
	
}
