package  {
	
	public class SentenceGameManager extends GameManager {
		
		var wordsContainer : Array;
		var totalImages : Array;
		
		var totalImagesLoaded : int;
		var currentStage : int;


		public function SentenceGameManager(manager : Main,gameContent : Object,gameType : String) {
			super(manager,gameType,gameContent);
			
			totalImagesLoaded = 0;
			currentStage = 0;
			wordsContainer = new Array(totalStages);
			totalImages = new Array(totalStages);
			
			for(var i : int = 0;i<totalStages;i++){
				wordsContainer[i] = new Array(gameContent.stages[i].articles,gameContent.stages[i].sustantivs,gameContent.stages[i].verbs,gameContent.stages[i].adjectives);
				totalImages[i] = gameContent.stages[i].answer;
			}			
			
			gameView = new SentenceGameView(this, gameType, totalImages);
			
		}
		
		public function checkSentence(articleData : int, sustantivoData : int,verbData : int,adjetiveData : int):void{
			if(articleData == sustantivoData == verbData == adjetiveData){
				currentStage++;
				
				resultColector.addCorrectAnswer();
				if(currentStage == totalStages){
					endGame();
				}else{
					SoundManager.playCorrectSound();
					(gameView as SentenceGameView).removeImage(currentStage - 1);
					buildNextStage();				
				}				
			}else{
				SoundManager.playWrongSound();
				resultColector.addWrongAnswer();
				trace("Incorrecto");
			}
		}
		
		override public function onOptionLoadComplete():void{
			totalImagesLoaded++;		
			if(totalImagesLoaded == totalStages){
				(gameView as SentenceGameView).createMadComponents();
				buildNextStage();
				onLoadComplete();
			}			
		}
		
		private function buildNextStage():void{
			(gameView as SentenceGameView).setOptions(wordsContainer[currentStage]);
			(gameView as SentenceGameView).showNextImage(currentStage);
		}
		

	}
	
}
