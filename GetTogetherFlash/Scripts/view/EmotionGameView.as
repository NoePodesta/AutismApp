package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	
	public class EmotionGameView extends MovieClip{

		
		var manager : EmotionGameManager;
		var emotionsGameScreen : MovieClip;	
		
		
		public function EmotionGameView(manager : EmotionGameManager) {
			this.manager = manager;
			emotionsGameScreen = new emotionGame_mc();
			emotionsGameScreen.backArrow_mc.addEventListener(TouchEvent.TOUCH_TAP,goBack);
			emotionsGameScreen.option0_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			emotionsGameScreen.option1_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			emotionsGameScreen.option2_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			emotionsGameScreen.option3_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			emotionsGameScreen.option4_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			emotionsGameScreen.option5_mc.addEventListener(TouchEvent.TOUCH_TAP, activateResult);
			addChild(emotionsGameScreen);
			
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.closeView();
		}
		
		public function setEmotion(emotion : String) : void {
			emotionsGameScreen.emotionLabel_txt.text = emotion;
		}
		
		public function activateResult(e : TouchEvent) : void {
			manager.checkAnswer(e.currentTarget as MovieClip);
		}
		
		public function getMovieClip() : MovieClip{
			return emotionsGameScreen;
		}
		

	}
	
}
