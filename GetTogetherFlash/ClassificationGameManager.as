package  {
	
	public class ClassificationGameManager extends GameManager{

		var options : Array;
		
		

		
		var optionsLength : int;
		
		var optionsQuantity : int;
		var totalCorrectAnswers : int;
		
		var answerAreas : Array;
		
		public function ClassificationGameManager(manager : Main,gameContent : Object, totalAnswerAreas : int, gameType : String) {
			super(manager, gameType, gameContent);
			
			optionsLength = gameContent.optionsLength;
			
			totalOptions = optionsLength;
			totalLoaded = 0;			
			options = new Array(optionsLength);						
			
			totalCorrectAnswers = 0;		
			
			if(gameContent.optionsType == "Text"){
				buildTextOptions();
			}else if(gameContent.optionsType == "Image"){
				buildImageOptions();
			}else if(gameContent.optionsType == "GIF"){
				buildGIFOptions();
			}
			
			answerAreas = new Array(totalAnswerAreas);
			
			for(var  i : int = 0; i<totalAnswerAreas;i++){
				answerAreas[i] = new ClassificationAnswerArea(this, "", i, 60);
				answerAreas[i].x = 150 + 500 * i;
			}
			
		
		
			
			
			
			
		}	
		
		private function buildTextOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){				
				options[i] = new DragableTextOption(this, gameContent.options[i].label,100 + 230 * i, 600, gameContent.options[i].classificationGroup);
			}
			
		}
		
		private function buildImageOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){
				options[i] = new DragableImageOption(this, gameContent.options[i].label,100 + 230 * i, 600, gameContent.options[i].classificationGroup);
			
			}
			
		}
		
		private function buildGIFOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){
				options[i] = new DragableGIFOption(this, gameContent.options[i].label,100 + 230 * i, 600, gameContent.options[i].classificationGroup);
			}
			
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == totalOptions){
				gameView = new ClassificationGameView(this, options, answerAreas, gameType);
				onLoadComplete();				
			}			
		}
		
		override public function checkClassificationAnswer(answer : ClassificationOption, dropped : ClassificationAnswerArea) : void{
			if(dropped != null){
				if(dropped.classificationGroup == answer.classificationGroup){
					totalCorrectAnswers++;
					if(totalCorrectAnswers == optionsLength){
						endGame();
					}
					//right.play();					
					
				}else{
					answer.resetPosition();
					//wrong.play();
				}
				
			}
		}
		

	}
	
}
