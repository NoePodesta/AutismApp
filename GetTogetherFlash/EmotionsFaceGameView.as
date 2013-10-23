package  {
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	import org.bytearray.gif.player.GIFPlayer;
	import org.bytearray.gif.decoder.GIFDecoder;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.FrameEvent;
	import org.bytearray.gif.events.TimeoutEvent;
	
	public class EmotionsFaceGameView extends GameView {
		
		
		

		
		var myGIFPlayer:GIFPlayer;
	
		
	

		public function EmotionsFaceGameView(manager : EmotionsFaceGameManager, graphicOptions : Array, correctAnswerURL : String) {
			super(manager);
			background = new emotionGameView_mc();
			setEventListeners();
			
			answerGraphicArea = new emotionGraphicAnswer_mc; 
			answerGraphicArea.y = 115;
			answerGraphicArea.x = 1024 / 2 - answerGraphicArea.width/2;
			
			myGIFPlayer = new GIFPlayer();
			myGIFPlayer.load ( new URLRequest (correctAnswerURL) );
			myGIFPlayer.addEventListener ( GIFPlayerEvent.COMPLETE, onCompleteGIFLoad );
			
			
			addChild(background);
			background.addChild(answerGraphicArea);
			
			var i : int;
			for(i = 0; i<graphicOptions.length;i++){
				addChildAt(graphicOptions[i],1);
			}
			
			
		}
		
		function onCompleteGIFLoad ( pEvt:GIFPlayerEvent ):void

		{
			myGIFPlayer.x = 15;
			myGIFPlayer.y = 10;
			answerGraphicArea.addChild ( myGIFPlayer );
			(manager as EmotionsFaceGameManager).loadGIFComplete();
			
			
		}

	}
	
}