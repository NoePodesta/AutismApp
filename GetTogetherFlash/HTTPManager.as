package  {
	
	import flash.net.*;	
	import flash.events.Event;
	

	
	public class HTTPManager {
		
		

		public function HTTPManager() {
			// constructor code
		}
		
		public function testConnection():void{
			var url:String = "http://localhost:9000/testConnection";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.GET;

			var variables:URLVariables = new URLVariables();
			
			
			request.data = variables;

			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}
		
		public function onComplete (event:Event):void {
			trace(event.target.data);
		}
		
		public function testLogin(username : String, password : String):void{
			var url:String = "http://localhost:9000/loginMobile";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;

			var variables:URLVariables = new URLVariables();
			variables.username = username;
			variables.password = password;
			
			request.data = variables;
			
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}

	}
	
}
