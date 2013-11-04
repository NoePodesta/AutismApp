package  {
	
	public class ConversationGameManager extends GameManager {

		var conversationFlow : Array;
		var conversationOptions : Array;
		
		var totalQuestions : int;
		
		var totalAnswered : int;
		public function ConversationGameManager(mainManager : Main, gameContent : Object, gameType : String) {
			super(mainManager,gameType,gameContent);
			
			conversationFlow = gameContent.conversationFlow;
			
			totalQuestions = gameContent.totalQuestions;
			totalAnswered = 0;
			conversationOptions = new Array(totalQuestions);
			for(var i : int = 0;i<totalQuestions;i++){
				conversationOptions[i] = gameContent.conversationStage[i];
			}
			
			
			
			
			gameView = new ConversationGameView(this, conversationFlow, conversationOptions, gameType);
			
			onLoadComplete();
		}
		
		public function checkSentence(result : Boolean):void{
			if(result){
				totalAnswered++;
				resultColector.addCorrectAnswer();
				if(totalAnswered == totalQuestions){
					endGame();
				}else{
					(gameView as ConversationGameView).proceedToNextQuestion();
				}
			}else{
				resultColector.addWrongAnswer();
				trace("Incorrecto");
			}
		}

	}
	
}
