package  {
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	public class CognitionUseGameView extends GameView {
		
		
		

		
		var answerImage : Bitmap;
		
		var imageLoader:Loader 
		
	

		public function CognitionUseGameView(manager : CognititionUseGameManager, graphicOptions : Array) {
			super(manager);
			background = new cognitionGameView_mc();
			setEventListeners();
			
			answerGraphicArea = new emotionGraphicAnswer_mc; 
			answerGraphicArea.width = 235;
			answerGraphicArea.height = 150;
			answerGraphicArea.y = 115;
			answerGraphicArea.x = 1024 / 2 - answerGraphicArea.width/2;
			
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPNGLoadComplete);
			imageLoader.load(new URLRequest("ElementsImages/hammer.png"));
			
			addChild(background);
			background.addChild(answerGraphicArea);
			
			var i : int;
			for(i = 0; i<graphicOptions.length;i++){
				addChildAt(graphicOptions[i],1);
			}
			
			
		}
		
		function onPNGLoadComplete(event : Event){
			answerImage = imageLoader.content as Bitmap;
			answerImage.width = answerGraphicArea.width;
			answerImage.height = answerGraphicArea.height;
			
			answerGraphicArea.addChild(answerImage);
			(manager as CognititionUseGameManager).loadPNGComplete();
		}

	}
	
}
