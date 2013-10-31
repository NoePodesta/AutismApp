package  {
	import flash.display.MovieClip;

	
	public class QAGameView extends GameView {
		
		var stagesOptions : Array;
		var stagesAnswerArea : Array;
	

		public function QAGameView(manager : GameManager, stagesOptions : Array, stagesAnswerArea : Array, gameType : String) {
			super(manager, gameType);
			
			this.stagesOptions = stagesOptions;
			this.stagesAnswerArea = stagesAnswerArea;
			
			
		}
		
		public function showStage(currentStage : int){
			background.addChild(stagesAnswerArea[currentStage]);			
			var i : int;
			for(i = 0; i<stagesOptions[currentStage].length;i++){
				addChildAt(stagesOptions[currentStage][i],1);
			}
			
		}
		
		public function removeStage(stageToRemove : int){
			background.removeChild(stagesAnswerArea[stageToRemove]);			
			var i : int;
			for(i = 0; i<stagesOptions[stageToRemove].length;i++){
				removeChild(stagesOptions[stageToRemove][i]);
			}
			
		}
		
		
		
	
	}
	
}