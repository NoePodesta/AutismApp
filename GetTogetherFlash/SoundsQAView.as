package  {
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class SoundsQAView extends QAGameView {

		var playButtonNormal : MovieClip;
		
		public function SoundsQAView(manager : GameManager, stagesOptions : Array, stagesAnswerArea : Array, gameType : String) {
			super(manager, stagesOptions,stagesAnswerArea,gameType);
			playButtonNormal = new PlayButton;
			playButtonNormal.addEventListener(TouchEvent.TOUCH_TAP,playSound);
			playButtonNormal.width = 50;
			playButtonNormal.height = 50;
			playButtonNormal.x = 1024 / 2 - 50 / 2;
			playButtonNormal.y = 768/ 2 - 50 / 2;
			addChild(playButtonNormal);
		}
		
		public function playSound(e : TouchEvent):void{
			(manager as SoundQAManager).playSound();
		}

	}
	
}
