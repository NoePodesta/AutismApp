﻿package  {
	
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class JSONLoader {

		var loadedJSON : Object;
		var mainManager : Main;
		var currentPackageName : String;
		
		
		public function JSONLoader(mainManager : Main) {
			this.mainManager = mainManager;
		}
		
		public function getJSON(url : String, currentPackageName : String):void{
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			this.currentPackageName = currentPackageName;
			
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(request);
			
		}
		
		
		private function onLoaderComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			loadedJSON = parseJSON(loader.data);
			loadedJSON.currentPackageName = currentPackageName;
			mainManager.loadGame(loadedJSON);
		}
		
		public function getLoadedJSON():Object{
			return loadedJSON;
		}
		
		public function stringifyJson(object : Object):String{
			var parsedJSON:String = JSON.stringify(object);
			return parsedJSON;
		}
		
		public function parseJSON(data : String):Object{
			return JSON.parse(data);
		}

	}
	
}
