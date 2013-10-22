package  {
	
	import flash.display.MovieClip;
	import org.bytearray.gif.player.GIFPlayer;
	import org.bytearray.gif.decoder.GIFDecoder;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.FrameEvent;
	import org.bytearray.gif.events.TimeoutEvent;
	
	import flash.net.URLRequest;

	import flash.events.TouchEvent;
	
	public class EmotionGameOption extends QAOption{
		
		
		// we create the GIFPlayer, GIF is played automatically
		var myGIFPlayer:GIFPlayer;
		var isInput : Boolean;
		
	
		
		var url : String;
		
		var started : Boolean;
		
		public function EmotionGameOption(url : String, positionX : int, positionY : int,dragable : Boolean, correctAnswer : Boolean, isInput : Boolean,manager : EmotionGameManager) {
			super(manager, new int(positionX), new int(positionY), correctAnswer);
			started = false;
			myGIFPlayer =  new GIFPlayer();
			// we show it
						
			// we load a GIF
			this.url = url;
			
			
			
			x = positionX;
			y = positionY;
			
			if(dragable){
				addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
			this.isInput = isInput;
			
			
			
		}	
		
		function onTouchBegin(e:TouchEvent) { 
			e.target.startTouchDrag(e.touchPointID); 
			myGIFPlayer.gotoAndStop(1);
			myGIFPlayer.play();
		} 
 
		function onTouchEnd(e:TouchEvent) { 
			e.target.stopTouchDrag(e.touchPointID);
			myGIFPlayer.gotoAndStop(1);
			gameManager.checkAnswer(this, e.stageX, e.stageY);
		}
		
		public function setCorrectAnswer(correctAnswer : Boolean) : void{
			this.correctAnswer = correctAnswer;
		}
		
		
		
		
		
		public function setCorrectPosition(positionX : int, positionY : int) : void{
			myGIFPlayer.gotoAndPlay(1);
			x = positionX;
			y = positionY;
		}
		
		public function loadGIF() : void{
			myGIFPlayer.load ( new URLRequest (url) );
			myGIFPlayer.addEventListener ( GIFPlayerEvent.COMPLETE, onCompleteGIFLoad );
			
		}
		
		function onCompleteGIFLoad ( pEvt:GIFPlayerEvent ):void

		{
			addChild ( myGIFPlayer );
			if(!isInput){
				myGIFPlayer.gotoAndStop(1);
			}
			(gameManager as EmotionGameManager).loadGifComplete();
			
			
		}
		
		public function stopGif() : void{
			myGIFPlayer.gotoAndStop(1);
		}
		
		public function startGif() : void{
			myGIFPlayer.gotoAndPlay(1);
		}
		
		public function endGif() : void{
			removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			myGIFPlayer.gotoAndPlay(1);
		}
		
		function onFrameRendered ( pEvt:FrameEvent ):void
		{
			
			
			//manager.setCompleteGif();			
		}
		
		

		
		


		
		

	}
	
}

