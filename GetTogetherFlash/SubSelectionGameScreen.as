package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class SubSelectionGameScreen extends MovieClip {

		var paquete : String;
		var selection : int;
		var manager : Main;
		
		var packageOptionPicker : PackageOptionPicker;
		
			
		public function SubSelectionGameScreen(manager : Main, packages:Array) {
			this.manager = manager;
			packageOptionPicker = new PackageOptionPicker(packages);
		}
		
		public function startGame(e : TouchEvent) : void{
			manager.startGame(this,selection,packageOptionPicker.getSelectedUrl());		
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.goBackToGameType(this);
		}

	}
	
}
