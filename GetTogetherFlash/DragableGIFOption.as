package  {
	
	import flash.events.TouchEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import org.bytearray.gif.player.GIFPlayer;
	import org.bytearray.gif.decoder.GIFDecoder;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.FrameEvent;
	import org.bytearray.gif.events.TimeoutEvent;	

	
	public class DragableGIFOption extends ClassificationOption {

		var myGIFPlayer:GIFPlayer;
		
		
		public function DragableGIFOption(gameManager : GameManager,content : String, positionX : int, positionY : int, group : int) {
			super(gameManager, new int(positionX), new int(positionY), group);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);		
			
			myGIFPlayer =  new GIFPlayer();
			myGIFPlayer.load ( new URLRequest (content) );
			myGIFPlayer.addEventListener ( GIFPlayerEvent.COMPLETE, onCompleteGIFLoad );
			
						
		}
		
		
				
		
		function onCompleteGIFLoad ( pEvt:GIFPlayerEvent ):void
		{
			y = originalY;
			x = originalX;
			originalWidth = this.width;
			originalHeight = this.height;
			addChild ( myGIFPlayer );
			
			gameManager.onOptionLoadComplete();
		}

		

	}
	
}