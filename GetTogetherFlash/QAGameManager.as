package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound; 
	
	import flash.geom.Rectangle;
		
	public class QAGameManager extends GameManager {

		
		var options : Array;
		var stagesOptions : Array;
		var stagesAnswers : Array;
		
		
		var right:Sound;
		var wrong:Sound;				
		var answerArea : ClassificationAnswerArea;
		
		
		var optionsLength : int;
		var currentStage : int;

		
		
		public function QAGameManager(mainManager : Main, gameContent : Object, gameType : String){
			super(mainManager, gameType, gameContent);
			optionsLength = 0;
			
			for(var i : int = 0;i<gameContent.totalStages;i++){
				optionsLength += gameContent.stages[i].optionsLength;
			}
			if(gameType == GameType.SOUND){
				totalOptions = optionsLength + (totalStages*2);
			}else{
				totalOptions = optionsLength + totalStages;
			}
			
			totalLoaded = 0;	
			currentStage = 0;
				
			stagesOptions = new Array(totalStages);
			stagesAnswers = new Array(totalStages);
			
			loadAllJSON();
			
		}
		
		private function buildTextOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){
				if(gameContent.stages[currentStage].options[i].correctAnswer){
					options[i] = new DragableTextOption(this, gameContent.stages[currentStage].options[i].label,50 + 250 * i, 650, 1);
				}else{
					options[i] = new DragableTextOption(this, gameContent.stages[currentStage].options[i].label,50 + 250 * i, 650, 0);
				}				
			}
			stagesOptions[currentStage] = options;
			
		}
		
		private function buildImageOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){
				if(gameContent.stages[currentStage].options[i].correctAnswer){
					options[i] = new DragableImageOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, 1);
				}else{
					options[i] = new DragableImageOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, 0);
				}				
			}
			stagesOptions[currentStage] = options;
			
		}
		
		private function buildGIFOptions(currentStage : int):void{
			for(var i :int = 0;i < gameContent.stages[currentStage].optionsLength ; i++){
				if(gameContent.stages[currentStage].options[i].correctAnswer){
					options[i] = new DragableGIFOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, 1);
				}else{
					options[i] = new DragableGIFOption(this, gameContent.stages[currentStage].options[i].label,100 + 230 * i, 600, 0);
				}				
			}
			stagesOptions[currentStage] = options;			
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == totalOptions){
				gameView = new QAGameView(this, stagesOptions, stagesAnswers, gameType);
				(gameView as QAGameView).showStage(currentStage);
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
			
				if(gameContent.stages[i].imageQuestion == "-1"){
					answerArea = new ClassificationTextAnswerArea(this,1,"SignsImages/QuestionMark.png",gameContent.stages[i].textQuestion,411);
				}else{
					answerArea = new ClassificationTextAnswerArea(this,1,gameContent.stages[i].imageQuestion,gameContent.stages[i].textQuestion,411);
				}
				/*	
				}else if(gameContent.stages[i].answerType == "Image"){
					answerArea = new ClassificationImageAnswerArea(this,1,gameContent.stages[i].answerLabel,gameContent.stages[i].answer,411);
				}				
				else if(gameContent.stages[i].answerType == "GIF"){
					answerArea = new ClassificationGIFAnswerArea(this,1,gameContent.stages[i].answerLabel,gameContent.stages[i].answer,50);
				}	
				*/
				stagesAnswers[i] = answerArea;
			}
			
		}
		
		override public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					
					currentStage++;
					resultColector.addCorrectAnswer();
					if(currentStage == totalStages){
						endGame();
					}else{
						SoundManager.playCorrectSound();
						(gameView as QAGameView).removeStage(currentStage-1);
						(gameView as QAGameView).showStage(currentStage);
					}
					
				}else{
					SoundManager.playWrongSound();
					answer.resetPosition();
					resultColector.addWrongAnswer();
				}
				
			}
		}
		
		
		
		
		
				

	}
	
}
