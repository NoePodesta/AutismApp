package  {
	
	public class ResultColector {
		
		var correctAnswers : int;
		var wrongAnswers : int;
		var gameType : String;
		var patient : int;
		var therapist : int;
		var packageUsed : int;
		
		var jsonLoader : JSONLoader;
		var json : String;
		

		public function ResultColector(gameType : String, packageUsed : int,patient : int, therapist : int) {
			correctAnswers = 0;
			wrongAnswers = 0;
			this.gameType = gameType;
			this.patient = patient;
			this.therapist = therapist;
			this.packageUsed = packageUsed;
			jsonLoader = new JSONLoader(null);
		}
		
		public function getJson():String{
			var object : Object = new Object;
			object.correctAnswers = correctAnswers;
			object.wrongAnswers = wrongAnswers;
			object.gameType = gameType;
			object.patient = patient;
			object.therapist = therapist;
			object.packageUsed = packageUsed;
			return jsonLoader.stringifyJson(object);
		}
		
		public function addCorrectAnswer():void{
			correctAnswers++;
		}
		
		public function addWrongAnswer():void{
			wrongAnswers++;
		}

	}
	
}
