package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class SubSelectionGameScreen extends MovieClip {

		var paquete : String;
		var selection : int;
		var manager : Main;
		
			
		public function SubSelectionGameScreen(manager : Main) {
			this.manager = manager;
		}
		
		public function startGame(e : TouchEvent) : void{
			manager.startGame(this,selection);		
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.goBackToGameType(this);
		}

	}
	
}
