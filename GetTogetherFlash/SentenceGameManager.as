package  {
	
	public class SentenceGameManager extends GameManager {

		public function SentenceGameManager(manager : Main,gameContent : Object,gameType : String) {
			super(manager,gameType,gameContent);
			
			gameView = new SentenceGameView(this, gameType,gameContent.articles,gameContent.sustantivs,gameContent.verbs,gameContent.adjectives,gameContent.answerImage);
			addChild(gameView);
		}
		
		public function checkSentence(articleData : int, sustantivoData : int,verbData : int,adjetiveData : int):void{
			if(articleData == sustantivoData == verbData == adjetiveData){
				endGame();
				resultColector.addCorrectAnswer();
			}else{
				resultColector.addWrongAnswer();
				trace("Incorrecto");
			}
		}

	}
	
}
