package  {
	
	import flash.display.MovieClip;
	
	public class QAOption extends MovieClip {

		var gameManager : GameManager;
		var originalX : int;
		var originalY : int;
		var correctAnswer : Boolean;
		
		public function QAOption(gameManager : GameManager, originalX : int, originalY : int, correctAnswer : Boolean) {
			this.gameManager = gameManager;
			this.originalX = originalX;
			this.originalY = originalY;
			this.correctAnswer = correctAnswer;
		}
		
		public function resetPosition() : void{
			x = originalX;
			y = originalY;
		}
		
		public function getCorrectAnswer() : Boolean{
			return correctAnswer;
		}

	}
	
}
