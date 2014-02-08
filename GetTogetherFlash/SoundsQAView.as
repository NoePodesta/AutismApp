package  {
	import flash.display.MovieClip;
	import flash.events.TouchEvent;

	
	public class SoundsQAView extends QAGameView {

		var playButtonNormal : MovieClip;
		
		public function SoundsQAView(manager : GameManager, stagesOptions : Array, stagesAnswerArea : Array, gameType : String) {
			super(manager, stagesOptions,stagesAnswerArea,gameType);
			playButtonNormal = new PlayButton;
			playButtonNormal.addEventListener(TouchEvent.TOUCH_TAP,playSound);
			playButtonNormal.x = 635.5;
			playButtonNormal.y = 202;
			addChild(playButtonNormal);		
		}
		
		public function playSound(e : TouchEvent):void{
			(manager as SoundQAManager).playSound();
		}
		
		override public function showStage(currentStage : int){
			background.addChild(stagesAnswerArea[currentStage]);
			setQuestion(stagesAnswerArea[currentStage].getQuestion());
			setImage(stagesAnswerArea[currentStage].getImage());
			var i : int;
			for(i = 0; i<stagesOptions[currentStage].length;i++){
				addChildAt(stagesOptions[currentStage][i],1);
			}
			
		}		
	

	}
	
}
