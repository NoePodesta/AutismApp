package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound; 
	
	import flash.geom.Rectangle;
		
	public class QAGameManager extends GameManager {

		var graphicOptions : Array;
		var textOptions : Array;
		
		//var answer : QAOption;
		
		var right:Sound;
		var wrong:Sound;
		
		var answerBoundaries : Rectangle;
		
		public function QAGameManager(mainManager : Main){
			super(mainManager);	
		}
		
		override public function checkAnswer(answer : QAOption, positionX : int, positionY : int) : void{
			var correctPosition : Boolean = false;
			if(positionY > answerBoundaries.top && positionY<answerBoundaries.bottom && positionX < answerBoundaries.right && positionX > answerBoundaries.left){
				correctPosition = true;
			}
			if(correctPosition){
				if(answer.getCorrectAnswer()){
					right.play();
					endGame();
				}else{
					wrong.play();
					answer.resetPosition();
				}	
			}else{
				answer.resetPosition();
			}
					
		}

	}
	
}
