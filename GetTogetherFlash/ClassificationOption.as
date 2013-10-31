package  {
	
	import flash.events.TouchEvent;
	
	public class ClassificationOption extends GameOption {

		
		var classificationGroup : int;
		
		public function ClassificationOption(gameManager : GameManager, originalX : int, originalY : int, classificationGroup : int) {
			super(gameManager, originalX, originalY);
			this.classificationGroup = classificationGroup;

			
		}
		
		public function getGroup():int{
			return classificationGroup;
		}
		
		function onTouchBegin(e:TouchEvent) { 
			startTouchDrag(e.touchPointID); 			
		} 
 
		function onTouchEnd(e:TouchEvent) { 
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
