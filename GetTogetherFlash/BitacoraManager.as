package  {
	
	import flash.display.MovieClip;
	import fl.controls.ScrollPolicy;
	import fl.controls.TextArea;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	public class BitacoraManager extends MovieClip {

		var bitacoraScreen : MovieClip;
		var plainTextArea:TextArea ;
		var main : Main;
		
		
		public function BitacoraManager(main : Main) {
			bitacoraScreen = new bitacoraScreen_mc;
			bitacoraScreen.goBackButton_mc.addEventListener(TouchEvent.TOUCH_TAP, goBackToMainScreen);
			bitacoraScreen.sendBitacora_mc.addEventListener(TouchEvent.TOUCH_TAP, sendBitacora);
			plainTextArea = new TextArea();
			plainTextArea.verticalScrollPolicy = ScrollPolicy.ON;
			plainTextArea.setSize(660, 380);
			plainTextArea.x = 1024/2 - 660 / 2;
			plainTextArea.y = 128;
			this.main = main;
			addChild(bitacoraScreen);
			addChild(plainTextArea);
			
		}
		
		public function goBackToMainScreen(e : Event):void{
			main.goBackToMainScreen(null);
		}
		
		public function sendBitacora(e : Event):void{
			main.sendBitacora(plainTextArea.text);
		}
		
	

	}
	
}
