package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	public class SoCoCoAnswerArea extends ClassificationAnswerArea{

		var countArea : MovieClip;
		var totalAnswers : int;
		var currentCount : int;

		
		public function SoCoCoAnswerArea(gameManager : SoCoCoGameManager,classificationGroup : int, optionName: String, totalAnswers : int){
			super(gameManager,"",classificationGroup,50);
			this.totalAnswers = totalAnswers;
			currentCount = 0;
			this.gameManager = gameManager;
		}
		
		public function addCountArea():void{
			countArea = new countLayer_mc;
			countArea.addEventListener(TouchEvent.TOUCH_TAP, addCount);
			
		}
		
		function addCount(e : Event):void{
			if(currentCount < totalAnswers){
				currentCount++;
				countArea.number_txt.text = currentCount; 
				if(currentCount == totalAnswers){
					countArea.removeEventListener(TouchEvent.TOUCH_TAP, addCount);
					(gameManager as SoCoCoGameManager).finishedCounting();
				}
			}
			
		}
		
		public function getCountArea():MovieClip{
			countArea.x = x + 25;
			countArea.y = y + 50;
			countArea.width = width;
			countArea.height = height;
			countArea.alpha = 0.5;
			return countArea;
		}
		
		public function askMinor():void{
			countArea.addEventListener(TouchEvent.TOUCH_TAP, checkMinor);
		}
		
		function checkMinor(e : TouchEvent):void{
			(gameManager as SoCoCoGameManager).checkIfMinor(currentCount);
		}
		
		public function askMayor():void{
			countArea.removeEventListener(TouchEvent.TOUCH_TAP, checkMinor);
			countArea.addEventListener(TouchEvent.TOUCH_TAP, checkMayor);
		}
		
		function checkMayor(e : TouchEvent):void{
			(gameManager as SoCoCoGameManager).checkIfMayor(currentCount);
		}


	}
	
}
