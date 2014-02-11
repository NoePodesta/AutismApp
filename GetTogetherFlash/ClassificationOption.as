package  {
	
	import flash.events.TouchEvent;
	
	public class ClassificationOption extends GameOption {

		
		var classificationGroup : int;
		var originalWidth : int;
		var originalHeight : int;
		
		public function ClassificationOption(gameManager : GameManager, originalX : int, originalY : int, classificationGroup : int) {
			super(gameManager, originalX, originalY);
			this.classificationGroup = classificationGroup;
		
			
		}
		
		public function getGroup():int{
			return classificationGroup;
		}
		
		function onTouchBegin(e:TouchEvent) { 
			width = width * 1.1;
			height = height * 1.1;
			startTouchDrag(e.touchPointID); 			
		} 
 
		function onTouchEnd(e:TouchEvent) { 
			width = originalWidth;
			height = originalHeight;
			stopTouchDrag(e.touchPointID);
			if(dropTarget != null){
				if(dropTarget.parent != null){
					if(dropTarget.parent.parent is ClassificationAnswerArea || dropTarget.parent.parent is SoCoCoAnswerArea){
						gameManager.checkClassificationAnswer(this, dropTarget.parent.parent as ClassificationAnswerArea);
					}else{
						resetPosition();
					}
				
				}
			}	
		}

	}
	
}
