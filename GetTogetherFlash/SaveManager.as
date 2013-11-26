package  {
	
	import flash.net.SharedObject;
	
	public class SaveManager {

		var mainManager : Main;
		
		public function SaveManager(mainManager : Main) {
			this.mainManager = mainManager;
		}
		
		public function addLocalResult(gameType : String, resultColector : ResultColector, offlineTherapist : String, offlinePatient : String){

			var offlineRecord: Object = new Object();
			offlineRecord.gameType = gameType;
			offlineRecord.offlineTherapist = offlineTherapist;
			offlineRecord.offlinePatient = offlinePatient;
			offlineRecord.correctAnswers = resultColector.correctAnswers;
			offlineRecord.wrongAnswers = resultColector.wrongAnswers;
			offlineRecord.packageUsed = resultColector.packageUsed;
			
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			if(so.data.offlineRecords == null){
				so.data.offlineRecords = new Array();
			}
			
			so.data.offlineRecords.push(offlineRecord);
		
			// And flush our changes.
			so.flush();
			
			mainManager.destroyGame();
			
		}
		
		public function getOfflineResults(dniTherapist : String):Array{
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			var therapistOfflineRecords : Array = new Array();
			if(so.data.offlineRecords != null){
				for(var i:int = 0;i<so.data.offlineRecords.length;i++){
					if(so.data.offlineRecords[i].offlineTherapist == dniTherapist){
						therapistOfflineRecords.push(so.data.offlineRecords[i]);
						
					}
				}	
			}
			
			
			
			return therapistOfflineRecords;
		}
		
		public function removeOfflineRecords(dniTherapist : String):void{
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			for(var i:int = 0;i<so.data.offlineRecords.length;i++){
				if(so.data.offlineRecords[i].offlineTherapist == dniTherapist){
					delete(so.data.offlineRecords[i]);
				}
			}	
			so.flush();
		}

	}
	
}
