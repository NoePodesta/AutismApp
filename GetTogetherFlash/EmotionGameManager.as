package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound; 
	
	public class EmotionGameManager extends MovieClip {

		
		var emotionOptions : Array;
		var emotionGameView : EmotionGameView;
		var buttonOptions : Array;
		var mainManager : Main;
		var correctAnswer : int;
		
		var right:Sound;
		var wrong:Sound;
		
		public function EmotionGameManager(mainManager : Main) {
			emotionGameView = new EmotionGameView(this);
			this.mainManager = mainManager;

			right = new RightSound();
			wrong = new WrongSound();
			//Sumamente choto
			buttonOptions = new Array(emotionGameView.getMovieClip().option0_mc,emotionGameView.getMovieClip().option1_mc,
										emotionGameView.getMovieClip().option2_mc,emotionGameView.getMovieClip().option3_mc,
										emotionGameView.getMovieClip().option4_mc,emotionGameView.getMovieClip().option5_mc);
			emotionOptions = new Array("Indistinto", "Enojado", "Sorprendido", "Frustrado", "Triste", "Contento");
		}
		
		public function closeView():void{
			removeChild(emotionGameView);
			mainManager.goToGameSelectionScreen();
		}
		
		public function showView() : void{
			addChild(emotionGameView);
		}
		
		public function startGame() : void{
			correctAnswer = Math.random() * 5;
			emotionGameView.setEmotion(emotionOptions[correctAnswer]);
		}
		
		public function checkAnswer(button : MovieClip){
			if(buttonOptions[correctAnswer] == button){
				right.play();
			}else{
				wrong.play();
			}
		}

	}
	
}
