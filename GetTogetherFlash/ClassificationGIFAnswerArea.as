package{
	

	import org.bytearray.gif.player.GIFPlayer;
	import org.bytearray.gif.decoder.GIFDecoder;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.FrameEvent;
	import org.bytearray.gif.events.TimeoutEvent;	
	
	
	import flash.net.URLRequest;
	

	
	public class ClassificationGIFAnswerArea extends ClassificationAnswerArea{

		
		
		var myGIFPlayer:GIFPlayer;
		
		public function ClassificationGIFAnswerArea(gameManager:GameManager, classificationGroup : int, optionName: String, content : String, positionY : int){
			super(gameManager, optionName, classificationGroup, positionY);				
			
			myGIFPlayer =  new GIFPlayer();
			myGIFPlayer.load ( new URLRequest (content) );
			myGIFPlayer.addEventListener ( GIFPlayerEvent.COMPLETE, onCompleteGIFLoad );		
		}
		
		
		
		function onCompleteGIFLoad ( pEvt:GIFPlayerEvent ):void
		{
			
			
			myGIFPlayer.x = display.width / 2 - 144 / 2;
			myGIFPlayer.y = 25;
			addChild(myGIFPlayer);
			x = 1024/2 - width/2;
			gameManager.onOptionLoadComplete();
			
		}
		
		
		
		
	
	}

}