package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class PackageSelectionScreen extends MovieClip {

		var packageSelectorScreen : MovieClip;
		var main : Main;
		
		var packageOptionPicker : PackageOptionPicker;
		
		
		public function PackageSelectionScreen(main : Main) {
			this.main = main;
			packageSelectorScreen = new packageSelectionScreen_mc;
			packageOptionPicker = new PackageOptionPicker();
			packageSelectorScreen.goBackButton_mc.addEventListener(TouchEvent.TOUCH_TAP,goBack);
			packageSelectorScreen.startGame_mc.addEventListener(TouchEvent.TOUCH_TAP,startGame);
			addChild(packageSelectorScreen);
			addChild(packageOptionPicker);
		}
		
		public function setPackages(packages : Array){
			packageOptionPicker.setPackages(packages);
		}
		
		public function goBack(e : TouchEvent) : void{
			main.goBackToGameType();
		}
		
		public function startGame(e : TouchEvent) : void{
			main.startGame(packageOptionPicker.getSelectedUrl(), packageOptionPicker.getSelectedPackageName());		
		}
		
		

	}
	
}
