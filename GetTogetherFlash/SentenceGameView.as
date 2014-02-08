﻿package  {
	
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
		
		
	
		var answerImage : Array;
		
		var imageLoader:Loader; 
		
		  
		var sustantivos : Array;
		var adjetivos : Array;
		var verbos : Array;
		var articulos : Array;
		
		
		var pickerSustantivos:UIPicker;
		var pickerArticulos:UIPicker;
		var pickerVerbos:UIPicker;
		var pickerAdjetivos:UIPicker;
		
	
		public function SentenceGameView(gameManager: GameManager,gameType : String, totalImages : Array){
			super(gameManager,gameType);
			
			answerImage = new Array(totalImages.length);
			

			for(var i : int = 0;i<totalImages.length;i++){
				imageLoader = new Loader();
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
				imageLoader.load(new URLRequest(totalImages[i]));
				answerImage[i] = imageLoader;
			}			
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
			manager.onOptionLoadComplete();
				
			
		}
		
		public function showNextImage(stageImage : int):void{
			answerImage[stageImage].y = 306+100/2;
			answerImage[stageImage].x = 1024/2-200/2;
			answerImage[stageImage].width = 200;
			answerImage[stageImage].height = 100;			
			addChild(answerImage[stageImage]);
		}
		
		public function removeImage(stageImage : int):void{
			removeChild(answerImage[stageImage]);
		}
		
		function createMadComponents(){
			pickerArticulos = new UIPicker(this, <picker/>, new Attributes(100,150,150,200), false, false);
			
			pickerArticulos.x =93+32;
			pickerArticulos.y = 92;
			
			
			pickerSustantivos = new UIPicker(this, <picker/>, new Attributes(250,150,150,200), false, false);
			
			pickerSustantivos.x =300+32;
			pickerSustantivos.y = 92;
			
			pickerVerbos = new UIPicker(this, <picker/>, new Attributes(400,150,150,200), false, false);
			
			pickerVerbos.x =505+32;
			pickerVerbos.y = 92;
			
			
			
			pickerAdjetivos = new UIPicker(this, <picker/>, new Attributes(550,150,150,200), false, false);	
			
			pickerAdjetivos.x =708+32;
			pickerAdjetivos.y = 92;
			
			
			
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
			
			var button:checkSentence_mc = new checkSentence_mc();
			button.y = 600;
			button.x = 387;
			button.addEventListener(TouchEvent.TOUCH_TAP, checkAnswer);
			addChild(button);
			
		}
		
		public function setOptions(words : Array):void{
			pickerArticulos.data = words[0];
			pickerVerbos.data = words[2];
			pickerAdjetivos.data = words[3];
			pickerSustantivos.data = words[1];
			
		}

	}
	
}
