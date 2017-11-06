package PetriNetManager {
	
	import PetriNetManager.ActionResult;
	public class StateTransition {

		private var id:Number;
		var inputStates:Vector.<State> = new Vector.<State>();
		var outputStates:Vector.<State> = new Vector.<State>();
		
		public function get Id():Number {
			return id;
		}		
		
		public function StateTransition( id,outputStates:Vector.<State>,inputStates:Vector.<State>) {
			this.id = id;
			this.outputStates = outputStates;
			this.inputStates = inputStates;
		}
		
		public function isActive():Boolean{
			
			for each ( var s:State in inputStates ){
				if(!s.hasMarkers())
					return false;
			}

			return true;
		}
		
		public function executeTransition():ActionResult{
			
			var canExecute = isActive();
			if(canExecute){
				
				var s:State;
				
				for each ( s in inputStates ){
					s.decMarkers();
				}
				
				for each ( s in outputStates ){
					s.incMarkers();
				}
			}
			return new ActionResult(canExecute, this.inputStates)
					
		}
		
		public function redoTransition(){
				var s:State;
				
				for each ( s in inputStates ){
					s.incMarkers();
				}
				
				for each ( s in outputStates ){
					s.decMarkers();
				}
		}
		
	}
	
}
