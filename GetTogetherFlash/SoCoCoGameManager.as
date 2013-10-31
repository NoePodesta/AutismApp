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
		
		public function SoCoCoGameManager(mainManager : Main, gameContent : Object,gameType : String) {
			super(mainManager,gameType,gameContent);
			totalA = gameContent.graphicOptions[0].quantity;
			totalB = gameContent.graphicOptions[1].quantity;
			totalC = gameContent.graphicOptions[2].quantity;
			this.optionsQuantity = totalA + totalB + totalC;
			
			this.currentStage = 0;
			this.totalLoaded = 0;
			this.correctClassificationAnswers = 0;
			
			graphicOptions = new Array(optionsQuantity);
			answerAreas = new Array(3);
			textClassificationOptions = new Array(3);
			
			
			
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
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[0].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[0].classificationGroup);
					totalAAdded++;
					i++;
				}
				if(i<4){
					yValue = 500;
				}else{
					yValue = 600;
				}
				if(totalBAdded < totalB){
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[1].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[1].classificationGroup);
					totalBAdded++;
					i++;
				}
				if(i<4){
					yValue = 500;
				}else{
					yValue = 600;
				}
				if(totalCAdded < totalC){
					graphicOptions[i] = new DragableImageOption(this, gameContent.graphicOptions[2].graphicOption,100 + (200 * (i%4)), yValue, gameContent.graphicOptions[2].classificationGroup);
					totalCAdded++;
					i++;
				}
			}
			
			for(var i : int = 0;i<3;i++){		
				if(i==0){
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].textOption, totalA);	
				}else if(i==1){
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].textOption, totalB);
				}else{
					answerAreas[i] = new SoCoCoAnswerArea(this,gameContent.answerAreas[i].classificationGroup, gameContent.answerAreas[i].textOption, totalC);
				}
				
			}
			
			gameView = new SoCoCoGameView(this,graphicOptions,answerAreas,gameType);
			
			for(var i : int= 0;i<3;i++){
				textClassificationOptions[i] = new DragableTextOption(this, gameContent.textOption[i].textOption,100 + 250 * i,500,gameContent.textOption[i].classificationGroup);
			}
			
		
			
			
		}
		
		override public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					if(currentStage==0){
						correctClassificationAnswers++;
						if(correctClassificationAnswers == optionsQuantity){
							goToColorStage();
							correctClassificationAnswers = 0;
						}
					}else if(currentStage == 1){
						correctClassificationAnswers++;
						if(correctClassificationAnswers == 3){
							goToCountStage();
							correctClassificationAnswers = 0;
						}
					}
					
					trace("Correcto");
					//right.play();
				}else{
					answer.resetPosition();
					//wrong.play();
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
				textClassificationOptions[i].y = 500;
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
					answerAreas[i].askMayor();				
				}	
			}
		}
		
		public function checkIfMayor(intValue : int):void{
			if(intValue >= totalA && intValue >=totalB && intValue>=totalC){
				endGame();
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
