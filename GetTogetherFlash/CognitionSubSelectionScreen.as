﻿package  {
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	
	public class CognitionSubSelectionScreen extends SubSelectionGameScreen  {

		var cognitionSubSelectionScreen : MovieClip;
		
		public function CognitionSubSelectionScreen(manager : Main) {
			super(manager);
			
			selection = 0;
			
			cognitionSubSelectionScreen = new cognitionGameSubSelectionScreen_mc();
			cognitionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			cognitionSubSelectionScreen.emotionsButton0_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame0);
			cognitionSubSelectionScreen.emotionsButton1_mc.addEventListener(TouchEvent.TOUCH_BEGIN, selectGame1);
			cognitionSubSelectionScreen.playButton_mc.addEventListener(TouchEvent.TOUCH_BEGIN, startGame);
			cognitionSubSelectionScreen.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN, goBack);
			addChild(cognitionSubSelectionScreen);
		}
		
		public function selectGame0(e : TouchEvent) : void{
			cognitionSubSelectionScreen.emotionsButton1_mc.gotoAndStop(1);
			cognitionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(2);
			selection = 0;		
		}
		
		public function selectGame1(e : TouchEvent) : void{
			cognitionSubSelectionScreen.emotionsButton0_mc.gotoAndStop(1);
			cognitionSubSelectionScreen.emotionsButton1_mc.gotoAndStop(2);
			selection = 1;		
		}
		
		
		
		
		

	}
	
}