package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class OfflineRecordScreenManager extends MovieClip {

		var mainManager : Main;
		var offlineRecordScreen : MovieClip;
		
		public function OfflineRecordScreenManager(offlineRecords : Array, mainManager : Main) {
			offlineRecordScreen = new offlineRecords_mc;
			offlineRecordScreen.sendData_mc.addEventListener(TouchEvent.TOUCH_TAP, sendOfflineRecords);
			offlineRecordScreen.offlineRecords_text.multiline = true;
			var stringToDisplay : String = "";
			for(var i : int = 0;i<offlineRecords.length;i++){
				stringToDisplay += offlineRecords[i].offlinePatient + " - ";
				stringToDisplay += offlineRecords[i].gameType + "";
				stringToDisplay += "\n";
			}
			offlineRecordScreen.offlineRecords_text.height = 42 * offlineRecords.length; 
			offlineRecordScreen.offlineRecords_text.text = stringToDisplay;
			offlineRecordScreen.x = 1024 / 2 - offlineRecordScreen.width / 2;
			offlineRecordScreen.y = 60;	
			this.mainManager = mainManager;
			addChild(offlineRecordScreen);
		}
		
		public function sendOfflineRecords(e : TouchEvent):void{
			mainManager.sendOfflineRecords();
		}

	}
	
}
