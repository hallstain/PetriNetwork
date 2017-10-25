﻿package MyPackage {
	
	import MyPackage.ActionResult;
	public class StateTransition {

		var id:Number;
		var inputStates:Vector.<State> = new Vector.<State>();
		var outputStates:Vector.<State> = new Vector.<State>();
		
		
		public function StateTransition( id,outputStates:Vector.<State>,inputStates:Vector.<State> ) {
			this.id = id;
			this.outputStates = outputStates;
			this.inputStates = inputStates;
		}
		
		private function check():Boolean{
			
			for each ( var s:State in inputStates ){
				if(!s.hasMarkers())
					return false;
			}

			return true;
		}
		
		public function executeTransition():ActionResult{
			
			var canExecute = check();
			if(canExecute){
				
				var s:State;
				
				for each ( s in inputStates ){
					s.decMarkers();
				}
				
				for each ( s in outputStates ){
					s.incMarkers();
				}
				trace("Input markers" +this.inputStates[0] );
			}
			return new ActionResult(canExecute, this.inputStates)
					
		}

	}
	
}