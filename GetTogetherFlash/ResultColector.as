package  {
	
	public class ResultColector {
		
		var correctAnswers : int;
		var wrongAnswers : int;
		var gameType : String;
		var packageUsed : String;
		var currentDate : String;
				

		public function ResultColector(gameType : String, packageUsed : String) {
			correctAnswers = 0;
			wrongAnswers = 0;
			this.gameType = gameType;			
			this.packageUsed = packageUsed;
			currentDate = new Date().toLocaleString();
		}
				
		public function addCorrectAnswer():void{
			correctAnswers++;
		}
		
		public function addWrongAnswer():void{
			wrongAnswers++;
		}

	}
	
}
