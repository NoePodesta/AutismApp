package  {
	
	import flash.events.TouchEvent;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;

	
	public class DragableImageOption extends ClassificationOption {

		var answerImage : Bitmap;		
		var imageLoader:Loader; 
	
		
		
		public function DragableImageOption(gameManager : GameManager,content : String, positionX : int, positionY : int, group : int) {
			super(gameManager, new int(positionX), new int(positionY), group);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);		
			
			
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			imageLoader.load(new URLRequest(content));	
						
		}		
				
		
		function onCompleteImageLoad(event : Event){
			answerImage = imageLoader.content as Bitmap;
			answerImage.width = 120;
			answerImage.height = 120;
			y = originalY;
			x = originalX;
			
			addChild(answerImage);
			originalWidth = this.width;
			originalHeight = this.height;
			gameManager.onOptionLoadComplete();
		}

		

	}
	
}