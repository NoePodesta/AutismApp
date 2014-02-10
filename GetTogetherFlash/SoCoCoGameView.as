package  {
	
	public class SoCoCoGameView extends GameView {

		public function SoCoCoGameView(manager: GameManager, totalAnswers: Array, totalAnswerAreas : Array,gameType : String){
			super(manager,gameType);			
			
			
			var answerAreaSpace  : int =  1024 / totalAnswerAreas.length;
			for(var j : int = 0;j<totalAnswerAreas.length;j++){
				totalAnswerAreas[j].x = answerAreaSpace * j;
				totalAnswerAreas[j].width = answerAreaSpace - 50;
				background.addChild(totalAnswerAreas[j]);				
			}
			
			for(var  i : int = 0;i<totalAnswers.length;i++){
				addChildAt(totalAnswers[i],1);
			}
		}
		
		public function setQuestion(question : String){
			background.question_txt.text = question;
		}

	}
	
}
