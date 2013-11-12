package  {
	
	import flash.events.Event; 
	import flash.media.Sound; 
	import flash.net.URLRequest; 
	
	public class SoundQAManager extends QAGameManager {
		
		var stagesSounds : Array;
		

		public function SoundQAManager(mainManager : Main, gameContent : Object, gameType : String){
			super(mainManager, gameContent, gameType);
			
		
			stagesSounds = new Array(gameContent.totalStages);
			
			for(var i : int = 0;i<totalStages;i++){
				var s:Sound = new Sound(); 
				s.addEventListener(Event.COMPLETE, onSoundLoaded); 
				var req:URLRequest = new URLRequest(gameContent.stages[i].sound);
				s.load(req);
				stagesSounds[i]=s;
			}
		}
		
		
		function onSoundLoaded(event:Event):void 
		{ 
			onOptionLoadComplete();
		}
		
		override public function onOptionLoadComplete():void{
			totalLoaded++;
			if(totalLoaded == totalOptions){
				gameView = new SoundsQAView(this, stagesOptions, stagesAnswers, gameType);
				(gameView as QAGameView).showStage(currentStage);
				onLoadComplete();				
			}			
		}
		
		public function playSound():void{
			stagesSounds[currentStage].play();
		}
		

	}
	
}
