package  {
	import flash.display.MovieClip;
		import flash.display.BitmapData;
	import flash.display.Bitmap;

	
	public class QAGameView extends GameView {
		
		var stagesOptions : Array;
		var stagesAnswerArea : Array;
		var firstTime : Boolean;
	

		public function QAGameView(manager : GameManager, stagesOptions : Array, stagesAnswerArea : Array, gameType : String) {
			super(manager, gameType);			
			this.stagesOptions = stagesOptions;
			this.stagesAnswerArea = stagesAnswerArea;			
			firstTime = true;
		}
		
		public function showStage(currentStage : int){
			background.addChild(stagesAnswerArea[currentStage]);
			setQuestion(stagesAnswerArea[currentStage].getQuestion());
			setImage(stagesAnswerArea[currentStage].getImage());
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
		
		protected function setQuestion(content : String){
			if(content!=null){
				background.questionTextArea_mc.content_txt.text = content;
			}			
		}
		
		protected function setImage(image : Bitmap){
			if(!firstTime){
				background.questionImageArea_mc.removeChildAt(1);
			}			
			image.width = 150;
			image.height = 200;
			image.x = background.questionImageArea_mc.width/2 - image.width/2;
			image.y = background.questionImageArea_mc.height/2 - image.height/2;
			background.questionImageArea_mc.addChildAt(image,1);
			firstTime = false;
		}
		
	
		
		
		
	
	}
	
}