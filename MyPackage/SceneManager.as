package  MyPackage {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import MyPackage.State;
	import MyPackage.StateTransition;
	import MyPackage.ActionResilt;
	import flash.display.Scene;
	
	public class SceneManager {
		var sceneStates:Vector.<State> = new Vector.<State>();
		var sceneTransitions:Vector.<StateTransition> = new Vector.<StateTransition>();
		
		public function SceneManager() {

		}		
		
		public function initFromJSONFile(jsonFilePath: String){
			var TextFileLoader:URLLoader = new URLLoader();

			TextFileLoader.addEventListener(Event.COMPLETE, onLoaded);
			TextFileLoader.load(new URLRequest(jsonFilePath));

			function onLoaded(e:Event):void {
				var netData: Object = JSON.parse(e.target.data);
				initStates(netData);
				initTransitions(netData);
			}
		}
		
		private function initStates(netData: Object){
			var stateIds: Array = netData.states;
			var stateMarkers: Array = netData.markers;
			sceneStates = new Vector.<StateTransition>();
			for( var i = 0; i < stateIds.length; ++i){
				sceneStates.push(new State(stateIds[i],stateMarkers[i]));
			}
		}
		
		private function initTransitions(netData: Object){
			var transitions: Array = netData.transitions;
			var statesMap: Object = new Object();
			for each ( s in sceneStates ){
				statesMap[s.id] = s;
			}
			sceneTransitions  = new Vector.<StateTransition>();
			for each ( t in transitions ){
				var inputStates = new Vector.<State>();
				var outputStates = new Vector.<State>();
				for each ( stateId in transitions.inputStates ){
					inputStates.push(statesMap[stateId]);
				}
				for each ( stateId in transitions.outputStates ){
					outputStates.push(statesMap[stateId]);
				}
				var isAutomatic = (t.isAutomatic === undefined)?(false):(true);
				sceneTransitions.push(new StateTransition(stateIds[i],
										outputStates, inputStates,isAutomatic));
			}
		}
		
		public makeAction(transitionId: int){
			for each ( t in sceneTransitions ){
				if(t.id === transitionId){
					var result: ActionResilt = t.executeTransition();
					break;
				}
			}
		}
	}
	
}
