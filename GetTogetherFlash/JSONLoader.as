package  {
	
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class JSONLoader {

		var loadedJSON : Object;
		var mainManager : Main;
		
		
		public function JSONLoader(mainManager : Main) {
			this.mainManager = mainManager;
		}
		
		public function getJSON(url : String):void{
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(request);
			
		}
		
		
		private function onLoaderComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			loadedJSON = JSON.parse(loader.data);	
			mainManager.loadGame(loadedJSON);
		}
		
		public function getLoadedJSON():Object{
			return loadedJSON;
		}
		
		public function parseJSON(object : Object):String{
			var parsedJSON:String = JSON.stringify(object);
			return parsedJSON;
		}

	}
	
}
