package  {
	
	import fl.data.DataProvider; 
	import fl.controls.ComboBox; 
	import flash.events.Event;
	
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	
	import flash.events.TouchEvent;
	
	import com.danielfreeman.madcomponents.Attributes;
	import com.danielfreeman.madcomponents.UIPicker;
	import com.danielfreeman.madcomponents.UIButton;
	
	public class SentenceGameView extends GameView{
		
		
	
		var answerImage : Bitmap;
		
		var imageLoader:Loader 
		
		  
		var sustantivos : Array;
		var adjetivos : Array;
		var verbos : Array;
		var articulos : Array;
		
		
		var pickerSustantivos:UIPicker;
		var pickerArticulos:UIPicker;
		var pickerVerbos:UIPicker;
		var pickerAdjetivos:UIPicker;
		
	
		public function SentenceGameView(gameManager: GameManager,gameType : String, articulos : Array, sustantivos : Array, verbos: Array, adjetivos : Array, url : String){
			super(gameManager,gameType);

			
			

			this.sustantivos = sustantivos;
			this.verbos = verbos;
			this.articulos = articulos;
			this.adjetivos = adjetivos;
			
			
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			imageLoader.load(new URLRequest(url));
			
		
			
				
			
		}
		
		function checkAnswer(event:Event):void { 
			//trace(picker0.row.data);
			if(pickerArticulos.index == -1){
				pickerArticulos.index = 0;
			}
			if(pickerSustantivos.index == -1){
				pickerSustantivos.index = 0;
			}
			if(pickerVerbos.index == -1){
				pickerVerbos.index = 0;
			}
			if(pickerAdjetivos.index == -1){
				pickerAdjetivos.index = 0;
			}
			(manager as SentenceGameManager).checkSentence(pickerArticulos.row.data, pickerSustantivos.row.data,pickerVerbos.row.data,pickerAdjetivos.row.data);

			
		}
		
		function onCompleteImageLoad (event : Event ):void
		{
			
			
			answerImage = imageLoader.content as Bitmap;
			answerImage.y = 768 / 2;
			answerImage.x = 1024 / 2 - 100;
			answerImage.width = 200;
			answerImage.height = 100;
			
			addChild(answerImage);
			
			
			
			
			createMadComponents();
			manager.onLoadComplete();
			
		}
		
		function createMadComponents(){
			pickerArticulos = new UIPicker(this, <picker/>, new Attributes(100,150,150,200), false, false);
			pickerArticulos.data = articulos;
			pickerArticulos.x =212;
			pickerArticulos.y = 100;
			
			
			pickerSustantivos = new UIPicker(this, <picker/>, new Attributes(250,150,150,200), false, false);
			pickerSustantivos.data = sustantivos;
			pickerSustantivos.x =362;
			pickerSustantivos.y = 100;
			
			pickerVerbos = new UIPicker(this, <picker/>, new Attributes(400,150,150,200), false, false);
			pickerVerbos.data = verbos;
			pickerVerbos.x =512;
			pickerVerbos.y = 100;
			
			
			
			pickerAdjetivos = new UIPicker(this, <picker/>, new Attributes(550,150,150,200), false, false);	
			pickerAdjetivos.data = adjetivos;
			pickerAdjetivos.x =662;
			pickerAdjetivos.y = 100;
			
			
			
			//WHY WHY WHY WHY
			removeChild(pickerArticulos);			
            addChild(pickerArticulos);
			
			//WHY WHY WHY WHY
			removeChild(pickerSustantivos);			
            addChild(pickerSustantivos);
			
			//WHY WHY WHY WHY
			removeChild(pickerVerbos);			
            addChild(pickerVerbos);
			
			//WHY WHY WHY WHY
			removeChild(pickerAdjetivos);			
            addChild(pickerAdjetivos);
			
			var button:UIButton = new UIButton(this, 20, 50, "Chequear", 0xCCFFCC, new <uint>[]);
			button.y = 300;
			button.x = 1024 / 2 - button.width /2;
			button.addEventListener(TouchEvent.TOUCH_TAP, checkAnswer);
			
			
		}

	}
	
}
