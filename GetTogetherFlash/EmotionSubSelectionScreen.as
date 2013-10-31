package  {
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	
	public class EmotionSubSelectionScreen extends SubSelectionGameScreen  {

		var emotionSubSelectionScreen : MovieClip;
		
		
		public function EmotionSubSelectionScreen(manager : Main, packages : Array) {
			super(manager, packages);
			
			selection = 0;			
			emotionSubSelectionScreen = new emotionGameSubSelectionScreen_mc();
			emotionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			emotionSubSelectionScreen.emotionsButton0_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame0);
			emotionSubSelectionScreen.emotionsButton1_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame1);
			emotionSubSelectionScreen.emotionsButton2_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame2);
			emotionSubSelectionScreen.playButton_mc.addEventListener(TouchEvent.TOUCH_BEGIN, startGame);
			emotionSubSelectionScreen.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN, goBack);
			addChild(emotionSubSelectionScreen);
			addChild(packageOptionPicker);
		}
		
		public function selectGame0(e : TouchEvent) : void{
			emotionSubSelectionScreen.emotionsButton1_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton2_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			selection = 0;		
		}
		
		public function selectGame1(e : TouchEvent) : void{
			emotionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton2_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton1_mc.gotoAndStop(2);
			selection = 1;		
		}
		
		public function selectGame2(e : TouchEvent) : void{
			emotionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton1_mc.gotoAndStop(1);
			emotionSubSelectionScreen.emotionsButton2_mc.gotoAndStop(2);
			selection = 2;		
		}
		
		
		
		

	}
	
}
