﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	
	public class GameView  extends MovieClip {

	
		var background : MovieClip;
		var manager : GameManager;
		var playingMusic : Boolean;
		
		
		
		public function GameView(manager : GameManager, gameType : String){
			this.manager = manager;
			playingMusic = true;
			
			if(gameType == GameType.QA || gameType == GameType.CONVERSATION){
				background = new cognitionGameView_mc();
			}else if(gameType == GameType.SENTENCE || gameType == GameType.SOCOCO){
				background = new emotionGameView_mc();
			}else if(gameType == GameType.CLASSIFICATION || gameType == GameType.SOUND){
				background = new communicationsGameView_mc();
			}
			addChild(background);
			setEventListeners();
		
		}
		
		function setEventListeners() : void{
			background.backArrow_mc.addEventListener(TouchEvent.TOUCH_BEGIN,goBack);
			background.stopMusic_mc.addEventListener(TouchEvent.TOUCH_BEGIN,changeMusicState);
		}
		
		public function goBack(e : TouchEvent) : void{
			manager.destroyGame(null);
		}
		
		public function changeMusicState(e : TouchEvent) : void{
			manager.changeMusicState(playingMusic);
			if(playingMusic){
				background.stopMusic_mc.gotoAndStop(2);
				playingMusic = false;
			}else{
				background.stopMusic_mc.gotoAndStop(1);
				playingMusic = true;
			}			
		}
		
	
	
	}
	
}
