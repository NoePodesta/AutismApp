package  {
	
	
	import flash.display.MovieClip;
	
	
	public class ClassificationAnswerArea extends MovieClip{

		var classificationGroup : int;
		var optionName : String;
		var display : MovieClip;		
		var gameManager : GameManager;
		
		
		public function ClassificationAnswerArea(gameManager : GameManager, optionName : String, classificationGroup : int, positionY : int) {
			this.classificationGroup = classificationGroup;
			this.optionName = optionName;
			this.gameManager = gameManager;
			display = new classificationAnswer_mc; 	
			
			addChild(display);
			y = positionY;
		}
		
		public function onLoadComplete():void{
			gameManager.onOptionLoadComplete();
		}

	}
	
	
	
}
