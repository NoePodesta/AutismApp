package  {
	
	import flash.net.*;	
	import flash.events.Event;
	

	
	public class HTTPManager {
		
		var topBar : TopBarView;
		var jsonLoader : JSONLoader;
		var main : Main;

		public function HTTPManager(main : Main, jsonLoader : JSONLoader) {
			this.main = main;
			this.jsonLoader = jsonLoader;
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
			trace("Completed url transaction");
		}
		
		public function onLoginComplete (event:Event):void {
			var loginData : Object = jsonLoader.parseJSON(event.target.data);
			if(loginData.loggedComplete){
				
				main.createTherapist(loginData);
			}else{
				//TODO Login Fail
				trace("Login failed");
			}
			
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
			loader.addEventListener(Event.COMPLETE, onLoginComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}
		
		public function setTopBar(topBar : TopBarView):void{
			this.topBar = topBar;
		}
		
		public function sendResults(gameType : String, resultColector : ResultColector, therapistId : int, patientId : int){
			var url:String = "http://localhost:9000/saveResults";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;

			var variables:URLVariables = new URLVariables();
			variables.gameType = gameType;
			variables.therapistId = therapistId;
			variables.patientId = patientId;
			variables.correctAnswers = resultColector.correctAnswers;
			variables.wrongAnswers = resultColector.wrongAnswers;
			
			request.data = variables;
			
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}

	}
	
}
