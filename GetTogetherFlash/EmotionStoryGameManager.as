package  {
	
	public class EmotionStoryGameManager extends QAGameManager{

		
		
		
		public function EmotionStoryGameManager(mainManager : Main) {
			super(mainManager);
			
			var correctAnswer : int = Math.random() * 4;
			graphicOptions = new Array(4);
						
			textOptions = new Array("Contento", "Triste", "Enojado", "Sorprendido");
			
			var i : int;
			for(i = 0;i < 4 ; i++){
				graphicOptions[i] = new DragableTextOption(this, textOptions[i],100 + 230 * i, 490, i == 0);
				
			}
			
			
			gameView = new EmotionStoryGameView(this, graphicOptions);
			
			answerBoundaries = gameView.getAnswerBoundaries();
			
			right = new RightSound();			
			wrong = new WrongSound();
			
			showView();
			
			
			
			
		}
		
		public function loadComplete() : void{
			//loadedGIFS++;
			//if(loadedGIFS == 5){
				onLoadComplete();
				loopJingle(null);
			//}
		}
		
		
		
		

	}
	
}
