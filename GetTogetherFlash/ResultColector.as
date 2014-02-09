package  {
	
	public class ResultColector {
		
		var correctAnswers : int;
		var wrongAnswers : int;
		var gameType : String;
		var patient : int;
		var therapist : int;
		var packageUsed : int;
		var currentDate : Date;
				

		public function ResultColector(gameType : String, packageUsed : int,patient : int, therapist : int) {
			correctAnswers = 0;
			wrongAnswers = 0;
			this.gameType = gameType;
			this.patient = patient;
			this.therapist = therapist;
			this.packageUsed = packageUsed;
			currentDate = new Date()
		}
				
		public function addCorrectAnswer():void{
			correctAnswers++;
		}
		
		public function addWrongAnswer():void{
			wrongAnswers++;
		}

	}
	
}
