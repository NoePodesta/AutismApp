package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound; 
	import flash.geom.Rectangle;
	
	public class EmotionGameManager extends QAGameManager {

		
		
		var emotionGameView : EmotionGameView;	
		
		var answer : EmotionGameOption;
		
		
		var loadedGIFS : int;
		
		public function EmotionGameManager(mainManager : Main) {
			super(mainManager);
			loadedGIFS = 0;
			var correctAnswer : int = Math.random() * 4;
			graphicOptions = new Array(4);
			var i : int;			
			textOptions = new Array("Contento", "Enojado", "Triste", "Sorprendido");
			for(i = 0; i < 4; i++){
				graphicOptions[i] = new EmotionGameOption("EmotionsGifs/happyBottom.gif", 200 + 200 * i, 490,true, correctAnswer == i,false,this);
			}		
			answer = new EmotionGameOption("EmotionsGifs/happyTop.gif", 410, 125, false, false,true,this);
			
			
			emotionGameView = new EmotionGameView(this, graphicOptions ,answer);
			emotionGameView.setCorrectEmotionText(textOptions[correctAnswer]);
			answerBoundaries = emotionGameView.getAnswerBoundaries();
			
			
			
			right = new RightSound();			
			wrong = new WrongSound();
			
			showView();
			
			
		}
		
		override public function showView() : void{
			var i : int;	
			for(i = 0; i < 4; i++){
				graphicOptions[i].loadGIF();
			}
			answer.loadGIF();
			addChild(emotionGameView);
		}
		
		
		override public function checkAnswer(answer : QAOption, positionX : int, positionY : int) : void{
			var correctPosition : Boolean = false;
			if(positionY > answerBoundaries.top && positionY<answerBoundaries.bottom && positionX < answerBoundaries.right && positionX > answerBoundaries.left){
				correctPosition = true;
			}
			if(correctPosition){
				if(answer.getCorrectAnswer()){
					right.play();
					(answer as EmotionGameOption).setCorrectPosition(410,237);
					(answer as EmotionGameOption).endGif();
					emotionGameView.startAnswerGif();
					endGame();
				}else{
					wrong.play();
					answer.resetPosition();
				}	
			}else{
				answer.resetPosition();
			}
					
		}
		
		public function loadGifComplete() : void{
			loadedGIFS++;
			if(loadedGIFS == 5){
				onLoadComplete();
				loopJingle(null);
			}
		}
		
		
		
		
	}
	
}
