package  {
	import flash.display.MovieClip;
	
	public class SoCoCoGameManager extends GameManager {
		
		var graphicOptions : Array;
		
		
		var currentStage : int;
		
		var classificationOptions : Array;		
		var answerAreas : Array;
		var textClassificationOptions : Array;
		var countLayers : Array;
		
		var optionsQuantity : int;
		var correctClassificationAnswers : int;
		
		var totalA : int;
		var totalB : int;
		var totalC : int;
		
		var totalTextQuestions : Array;
		public function SoCoCoGameManager(mainManager : Main, gameContent : Object,gameType : String) {
			super(mainManager,gameType,gameContent);

			
			this.currentStage = 0;
			this.totalLoaded = 0;
			this.correctClassificationAnswers = 0;
			
			this.totalA = gameContent.totalA;
			this.totalB = gameContent.totalB;
			this.totalC = gameContent.totalC;
			
			optionsQuantity = totalA + totalB + totalC;
			
			graphicOptions = new Array(optionsQuantity);
			answerAreas = new Array(3);
			textClassificationOptions = new Array(3);
			
			this.totalTextQuestions = gameContent.questions;
			
			var totalAAdded : int = 0;
			var totalBAdded : int = 0;
			var totalCAdded : int = 0;
			var yValue : int;
			
			for(var i : int = 0;i < optionsQuantity ; ){	
				if(i<4){
					yValue = 500;
				}else{
					yValue = 600;
				}
				if(totalAAdded < totalA){
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[i].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[i].classificationGroup);
					totalAAdded++;
					i++;
				}
				if(i<4){
					yValue = 500;
				}else{
					yValue = 600;
				}
				if(totalBAdded < totalB){
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[i].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[i].classificationGroup);
					totalBAdded++;
					i++;
				}
				if(i<4){
					yValue = 500;
				}else{
					yValue = 600;
				}
				if(totalCAdded < totalC){
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[i].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[i].classificationGroup);
					totalCAdded++;
					i++;
				}
			}
			
			for(var i : int = 0;i<3;i++){		
				if(i==0){
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].label, totalA);	
				}else if(i==1){
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].label, totalB);
				}else{
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].label, totalC);
				}
				
			}
			
			gameView = new SoCoCoGameView(this,graphicOptions,answerAreas,gameType);
			(gameView as SoCoCoGameView).setQuestion(totalTextQuestions[0]);
			
			for(var i : int= 0;i<3;i++){
				textClassificationOptions[i] = new DragableTextOption(this, gameContent.textOption[i].label,100 + 250 * i,500,gameContent.textOption[i].classificationGroup);
			}
			
		
			
			
		}
		
		override public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					if(currentStage==0){
						correctClassificationAnswers++;
						resultColector.addCorrectAnswer();
						if(correctClassificationAnswers == optionsQuantity){
							(gameView as SoCoCoGameView).setQuestion(totalTextQuestions[1]);
							goToColorStage();
							correctClassificationAnswers = 0;
						}
					}else if(currentStage == 1){
						correctClassificationAnswers++;
						resultColector.addCorrectAnswer();
						if(correctClassificationAnswers == 3){
							(gameView as SoCoCoGameView).setQuestion(totalTextQuestions[2]);
							goToCountStage();
							correctClassificationAnswers = 0;
						}
					}
					SoundManager.playCorrectSound();
				}else{
					resultColector.addWrongAnswer();
					answer.resetPosition();
					SoundManager.playWrongSound();
				}
				
			}
		}
		
		override public function loadImageComplete() : void{
			totalLoaded++;
			if(totalLoaded == optionsQuantity){
				
				onLoadComplete();
			}
			
			
		}
		
		public function goToColorStage():void{
			for(var i : int = 0;i<3;i++){
				addChild(textClassificationOptions[i]);
				textClassificationOptions[i].x = 100 + 250 * i;
				textClassificationOptions[i].y = 600;
			}
			currentStage++;
		}
		
		public function goToCountStage():void{
			for(var i : int = 0;i<3;i++){
				answerAreas[i].addCountArea();				
				addChild(answerAreas[i].getCountArea());
			}
			
		}
		
		public function finishedCounting():void{
			correctClassificationAnswers++;
			if(correctClassificationAnswers == 3){
				(gameView as SoCoCoGameView).setQuestion(totalTextQuestions[3]);
				goToQuestionsStage();
			}
		}
		
		public function goToQuestionsStage():void{
			for(var i : int = 0;i<3;i++){
				answerAreas[i].askMinor();				
			}			
		}
		
		public function checkIfMinor(intValue : int):void{
			if(intValue <= totalA && intValue <=totalB && intValue<=totalC){
				for(var i : int = 0;i<3;i++){
					(gameView as SoCoCoGameView).setQuestion(totalTextQuestions[4]);
					answerAreas[i].askMayor();				
				}	
			}else{
				SoundManager.playWrongSound();
			}
		}
		
		public function checkIfMayor(intValue : int):void{
			if(intValue >= totalA && intValue >=totalB && intValue>=totalC){
				endGame();
			}else{
				SoundManager.playWrongSound();
			}
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == optionsQuantity){
				onLoadComplete();				
			}	
		}

	}
	
}
