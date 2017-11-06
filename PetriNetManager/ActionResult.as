package PetriNetManager {
	
	public class ActionResult {

		var successed:Boolean;
		var inputStates:Vector.<State> = new Vector.<State>();
		
		public function ActionResult( successed, inputStates:Vector.<State> ) {
			this.successed = successed;
			this.inputStates = inputStates;
		}
		
		public function isSuccessed():Boolean{
			return successed;
		}
		public function getInputStates():Vector.<State>{
			return inputStates;
		}

	}
	
}
