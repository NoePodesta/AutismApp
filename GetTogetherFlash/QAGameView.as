package  {
	import flash.display.MovieClip;

	
	public class QAGameView extends GameView {
		
	

		public function QAGameView(manager : GameManager, options : Array, answerArea : MovieClip, gameType : String) {
			super(manager, gameType);
			
			background.addChild(answerArea);			
			var i : int;
			for(i = 0; i<options.length;i++){
				addChildAt(options[i],1);
			}
			
			
		}
		
		
		
	
	}
	
}