package  {
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	
	public class CommunicationSubSelectionScreen extends SubSelectionGameScreen  {

		var communicationSubSelectionScreen : MovieClip;
		
		public function CommunicationSubSelectionScreen(manager : Main, packages : Array) {
			super(manager, packages);
			
			selection = 0;
			
			communicationSubSelectionScreen = new communicationGameSubSelectionScreen_mc();
			communicationSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			communicationSubSelectionScreen.emotionsButton0_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame0);
			communicationSubSelectionScreen.emotionsButton1_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame1);
			communicationSubSelectionScreen.playButton_mc.addEventListener(TouchEvent.TOUCH_BEGIN, startGame);
			communicationSubSelectionScreen.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN, goBack);
			addChild(communicationSubSelectionScreen);
			addChild(packageOptionPicker);
		}
		
		public function selectGame0(e : TouchEvent) : void{
			communicationSubSelectionScreen.emotionsButton1_mc.gotoAndStop(1);
			communicationSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			selection = 0;		
		}
		
		public function selectGame1(e : TouchEvent) : void{
			communicationSubSelectionScreen.emotionsButton0_mc.gotoAndStop(1);
			communicationSubSelectionScreen.emotionsButton1_mc.gotoAndStop(2);
			selection = 1;		
		}
		
		
		
		
		

	}
	
}