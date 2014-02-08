package  {
	
	import flash.events.TouchEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;

	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class DragableTextOption extends ClassificationOption {		
	
		
		var dragableTextIcon : DragableTextIcon;
		
		
		public function DragableTextOption(gameManager : GameManager,content : String, positionX : int, positionY : int, group : int) {
			super(gameManager, new int(positionX), new int(positionY), group);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			dragableTextIcon = new DragableTextIcon();
			dragableTextIcon.content_txt.text = content;	
						
			addChild(dragableTextIcon);
			onCompleteTextLoad();	
			
		}

				
		
		function onCompleteTextLoad ():void
		{
			y = originalY;
			x = originalX;
			
			gameManager.onOptionLoadComplete();
		}
		

	}
	
}