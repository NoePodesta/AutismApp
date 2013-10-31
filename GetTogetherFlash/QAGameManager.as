package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound; 
	
	import flash.geom.Rectangle;
		
	public class QAGameManager extends GameManager {

		
		var options : Array;
		
		//var answer : QAOption;
		
		var right:Sound;
		var wrong:Sound;				
		var answerArea : ClassificationAnswerArea;
		
		
		var optionsLength : int;

		
		
		public function QAGameManager(mainManager : Main, gameContent : Object, gameType : String){
			super(mainManager, gameType, gameContent);
		
			optionsLength = gameContent.optionsLength;
			
			totalOptions = optionsLength + 1;
			totalLoaded = 0;			
			options = new Array(optionsLength);						
			
			
			if(gameContent.optionsType == "Text"){
				buildTextOptions();
			}else if(gameContent.optionsType == "Image"){
				buildImageOptions();
			}else if(gameContent.optionsType == "GIF"){
				buildGIFOptions();
			}
			
			if(gameContent.answerType == "Text"){
				answerArea = new ClassificationTextAnswerArea(this,1,"",gameContent.answer,50);
				answerArea.onLoadComplete();
			}else if(gameContent.answerType == "Image"){
				answerArea = new ClassificationImageAnswerArea(this,1,"",gameContent.answer,50);
			}else if(gameContent.answerType == "GIF"){
				answerArea = new ClassificationGIFAnswerArea(this,1,"",gameContent.answer,50);
			}
		}
		
		private function buildTextOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){
				if(gameContent.options[i].correctAnswer){
					options[i] = new DragableTextOption(this, gameContent.options[i].label,100 + 230 * i, 600, 1);
				}else{
					options[i] = new DragableTextOption(this, gameContent.options[i].label,100 + 230 * i, 600, 0);
				}				
			}
			
		}
		
		private function buildImageOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){
				if(gameContent.options[i].correctAnswer){
					options[i] = new DragableImageOption(this, gameContent.options[i].label,100 + 230 * i, 600, 1);
				}else{
					options[i] = new DragableImageOption(this, gameContent.options[i].label,100 + 230 * i, 600, 0);
				}				
			}
			
		}
		
		private function buildGIFOptions():void{
			for(var i :int = 0;i < optionsLength ; i++){
				if(gameContent.options[i].correctAnswer){
					options[i] = new DragableGIFOption(this, gameContent.options[i].label,100 + 230 * i, 600, 1);
				}else{
					options[i] = new DragableGIFOption(this, gameContent.options[i].label,100 + 230 * i, 600, 0);
				}				
			}
			
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == totalOptions){
				gameView = new QAGameView(this, options, answerArea, gameType);
				onLoadComplete();
				
			}			
		}
		
		
		
				

	}
	
}
