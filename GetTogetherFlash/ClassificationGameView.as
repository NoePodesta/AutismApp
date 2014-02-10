package  {
	
	public class ClassificationGameView extends GameView {

		
		var stagesOptions : Array;
		var stagesAnswerAreas : Array;
		var questions : Array;
		
		
		public function ClassificationGameView(manager: GameManager, stagesOptions: Array, stagesAnswerAreas : Array,gameType : String,questions : Array){
			super(manager, gameType);		
		
			this.stagesOptions = stagesOptions;
			this.stagesAnswerAreas = stagesAnswerAreas;
			this.questions = questions;
		}
		
		public function showStage(currentStage : int){
			background.question_txt.text = questions[currentStage];
			for(var i : int = 0;i<stagesAnswerAreas[currentStage].length;i++){
				background.addChild(stagesAnswerAreas[currentStage][i]);
			}
						
			for(var i : int = 0; i<stagesOptions[currentStage].length;i++){
				addChildAt(stagesOptions[currentStage][i],1);
			}
			
		}
		
		public function removeStage(stageToRemove : int){
			for(var i : int = 0;i<stagesAnswerAreas[stageToRemove].length;i++){
				background.removeChild(stagesAnswerAreas[stageToRemove][i]);
			}	
			for(var i : int = 0; i<stagesOptions[stageToRemove].length;i++){
				removeChild(stagesOptions[stageToRemove][i]);
			}
			
		}

	
	
	}
	
}
