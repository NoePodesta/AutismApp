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
			if(gameManager.gameType == GameType.SOUND){
				display = new classificationSoundAnswer_mc; 
				display.x = 277.5;
				display.y = 472.55;
			}else if(gameManager.gameType == GameType.QA){
				display = new classificationQAAnswer_mc;
				display.x = 277.5
				display.y = 472.55;
			}else if(gameManager.gameType == GameType.CLASSIFICATION){
				display = new classificationGameAnswer_mc;
				display.x = 100 + 400 * classificationGroup;
				display.y = positionY;
				if(optionName != null){
					display.descriptionText_txt.text = optionName;
				}
			}else if(gameManager.gameType == GameType.SOCOCO){
				display = new classificationSoCoCoAnswer_mc;
				display.x = 25;
				display.y = positionY;
				if(optionName != null){
					display.descriptionText_txt.text = optionName;
				}
			}					
			addChild(display);			
		}
		
	
		public function onLoadComplete():void{
			gameManager.onOptionLoadComplete();
		}
		
	

	}
	
	
	
}
