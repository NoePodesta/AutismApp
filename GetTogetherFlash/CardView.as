package  {
	
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	public class CardView extends MovieClip {

		var imageUrl : String;
		var description : String;
		var card : MovieClip;
		
		var answerImage : Bitmap;
		
		var imageLoader:Loader 
	
	
		
		var cardManager : CardManager;
		
		public function CardView(cardManager : CardManager,imageUrl : String, description : String) {
			this.cardManager = cardManager;
			
			card = new cardScreen_mc;
			
			
			card.description_txt.text = description;
			
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPNGLoadComplete);
			imageLoader.load(new URLRequest(imageUrl));
			
	
			card.description_txt.text = description;
			//card.description_txt.width = card.description_txt.textWidth;
			
			addChild(card);
		}
		
		function onPNGLoadComplete(event : Event){
			answerImage = imageLoader.content as Bitmap;
			answerImage.width = card.imageContainer_mc.width;
			answerImage.height = card.imageContainer_mc.height;
			
			card.imageContainer_mc.addChild(answerImage);
			cardManager.loadCardComplete();
		}

	}
	
}
