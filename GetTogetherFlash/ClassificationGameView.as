package  {
	
	public class ClassificationGameView extends GameView {

		
		public function ClassificationGameView(manager: GameManager, totalAnswers: Array, totalAnswerAreas : Array,gameType : String){
			super(manager, gameType);		
		
			for(var j : int = 0;j<totalAnswerAreas.length;j++){
				background.addChild(totalAnswerAreas[j]);				
			}
			
			for(var  i : int = 0;i<totalAnswers.length;i++){
				addChildAt(totalAnswers[i],1);
			}
			
			
		}

	
	
	}
	
}
