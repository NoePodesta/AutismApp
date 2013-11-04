package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class TopBarView extends MovieClip{

		var topBar : MovieClip;
		var httpManager : HTTPManager;
		
		public function TopBarView(httpManager : HTTPManager) {
			this.httpManager = httpManager;
			httpManager.setTopBar(this);
			topBar = new topBar_mc;
			topBar.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
			addChild(topBar);
		}
		
		public function testLogin(e : TouchEvent):void{
			httpManager.testLogin(topBar.username_txt.text, topBar.password_txt.text);
		}
		
		public function testConnection(e : TouchEvent):void{
			httpManager.testConnection();
		}
		
		public function loggedIn(result : String):void{
			topBar.gotoAndStop(2);
			topBar.loggedUser_txt.text = "";
			topBar.loggedUser_txt.text = result;
		}

	}
	
}
