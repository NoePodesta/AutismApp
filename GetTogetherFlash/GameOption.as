package  {
	
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	public class GameOption extends MovieClip {

		var gameManager : GameManager;
		var originalX : int;
		var originalY : int;
		
		public function GameOption(gameManager : GameManager, originalX : int, originalY : int)  {
			this.gameManager = gameManager;
			this.originalX = originalX;
			this.originalY = originalY;
		}

		
		public function resetPosition() : void{
			new Tween(this, "x", None.easeOut, x, originalX, 1, true);
			new Tween(this, "y", None.easeOut, y, originalY, 1, true);
			
			//x = originalX;
			//y = originalY;
		}
	}
	
}
