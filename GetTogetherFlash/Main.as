package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.events.Event;
    import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.ui.Keyboard;

	
	public class Main extends MovieClip {

		var mainScreen : MovieClip;
		var gameSelectionScreen : MovieClip;
		var emotionManager : EmotionGameManager;
		var httpManager : HTTPManager;
		
		
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;				
			//Initialize Views			
			mainScreen = new mainScreen_mc();
			gameSelectionScreen = new gameSelectionScreen_mc;
			addChild(mainScreen);
			//Initialize Managers
			emotionManager = new EmotionGameManager(this);
			httpManager = new HTTPManager();
			//Initialize events
			mainScreen.initializeApplicationButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToGameSelectionScreenEvent);
			mainScreen.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
			gameSelectionScreen.emotionsButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goToEmotionsGame);
			
			/*
			mainScreen.username_txt.addEventListener( Event.CHANGE, onTFChange );
            mainScreen.username_txt.addEventListener( SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, softKeyboardEvent );
            mainScreen.username_txt.addEventListener( SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, softKeyboardEvent );
			*/
		}
		
		public function goToGameSelectionScreenEvent(e : TouchEvent) : void{
			removeChild(mainScreen);
			goToGameSelectionScreen();
			
		}		
		
		public function goToEmotionsGame(e : TouchEvent) : void{
			removeChild(gameSelectionScreen);			
			addChild(emotionManager);
			emotionManager.showView();
			emotionManager.startGame();
		}
		
		public function goToGameSelectionScreen(){
			gameSelectionScreen.gotoAndPlay(0);
			addChild(gameSelectionScreen);	
		}
		
		public function testConnection(e : TouchEvent):void{
			httpManager.testConnection();
		}
		
		public function testLogin(e : TouchEvent):void{
			httpManager.testLogin(mainScreen.username_txt.text, mainScreen.password_txt.text);
		}
		
		private function showKeyboard( event:Event ):void{
            trace("show");
            mainScreen.username_txt.requestSoftKeyboard();
        }
		
        private function hideKeyboard( event:Event ):void{
            trace("hide");
            this.stage.focus = null;
        }
		
        private function onTFChange( event:Event ):void{
            trace("Character typed: " + mainScreen.username_txt.text.charAt( mainScreen.username_txt.text.length - 1 ) );
            //mainScreen.username_txt.text = "";
        }    
		
        private function softKeyboardEvent( event:SoftKeyboardEvent ):void{
            trace( this.stage.softKeyboardRect );
        }

	
	}
}