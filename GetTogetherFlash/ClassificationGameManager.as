package  {
	import flash.display.JointStyle;
	
	public class ClassificationGameManager extends GameManager{

		var options : Array;
		var currentStage : int;
		var totalCorrectAnswers : int;
		
		
		var stagesOptions : Array;
		var stagesQuestions : Array;
		var stagesAnswers : Array;
		
		public function ClassificationGameManager(manager : Main,gameContent : Object, totalAnswerAreas : int, gameType : String) {
			super(manager, gameType, gameContent);
			
			for(var i : int = 0;i<gameContent.totalStages;i++){
				totalOptions += gameContent.stages[i].optionsLength;
			}
			
			
			totalLoaded = 0;	
			currentStage = 0;
				
			stagesOptions = new Array(totalStages);
			stagesAnswers = new Array(totalStages);
			stagesQuestions = new Array(totalStages);
			for(var i : int = 0;i<gameContent.totalStages;i++){
				stagesAnswers[i] = new Array(gameContent.stages[i].totalAnswerAreas);
				stagesQuestions[i] = new Array(gameContent.stages[i].stageQuestion);
			}
			
			
			totalCorrectAnswers = 0;		
			
		
			
			loadAllJSON();			
			
			
		}	
		
	
		private function buildTextOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){				
				options[i] = new DragableTextOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, gameContent.stages[currentStage].options[i].classificationGroup);
			}
			stagesOptions[currentStage] = options;
		}
		
		private function buildImageOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){	
				options[i] = new DragableImageOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, gameContent.stages[currentStage].options[i].classificationGroup);
			}
			stagesOptions[currentStage] = options;
			
		}
		
		private function buildGIFOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){	
				options[i] = new DragableGIFOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, gameContent.stages[currentStage].options[i].classificationGroup);
			}
			
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == totalOptions){
				gameView = new ClassificationGameView(this, stagesOptions, stagesAnswers, gameType,stagesQuestions);
				(gameView as ClassificationGameView).showStage(currentStage);
				onLoadComplete();				
			}			
		}
		
		public function loadAllJSON():void{
			
			for(var i: int = 0;i<totalStages;i++){
				options = new Array(gameContent.stages[i].optionsLength);
				if(gameContent.stages[i].optionsType == "Text"){
					buildTextOptions(i);
				}else if(gameContent.stages[i].optionsType == "Image"){
					buildImageOptions(i);
				}else if(gameContent.stages[i].optionsType == "GIF"){
					buildGIFOptions(i);
				}
				
				for(var  j : int = 0; j<gameContent.stages[i].totalAnswerAreas;j++){
					var answerArea : ClassificationAnswerArea = new ClassificationAnswerArea(this, gameContent.stages[i].answerLabel[j], j, 100);
	
					stagesAnswers[i][j] = answerArea;
				}
				
			}
			
		}
		
		override public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					totalCorrectAnswers++;
					resultColector.addCorrectAnswer();
					
					if(totalCorrectAnswers == gameContent.stages[currentStage].optionsLength){
						currentStage++;
						if(currentStage == totalStages){
							endGame();
						}else{							
							SoundManager.playCorrectSound();
							(gameView as ClassificationGameView).removeStage(currentStage-1);
							(gameView as ClassificationGameView).showStage(currentStage);
							totalCorrectAnswers = 0;
						}
					}
				}else{
					resultColector.addWrongAnswer();
					SoundManager.playWrongSound();
					answer.resetPosition();
				}
				
			}
		}
		

	}
	
}
