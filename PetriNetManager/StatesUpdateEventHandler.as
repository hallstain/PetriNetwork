package  PetriNetManager{
	import flash.events.Event;
	import PetriNetManager.State;
	
	public class StatesUpdateEventHandler extends Event
	{
		public static const STATES_UPDATE_EVENT:String = "statesUpdateEvent"; 

		var params:Vector.<State>;		
		
		public function get States(): Vector.<State>{
			return params;
		}
		
		public function StatesUpdateEventHandler($type:String, $params:Vector.<State>, $bubbles:Boolean = false, $cancelable:Boolean = false)
		{
			super($type, $bubbles, $cancelable);
			this.params = $params;
		}

		public override function clone():Event
		{
			return new StatesUpdateEventHandler(type, this.params, bubbles, cancelable);
		}
	}
}
