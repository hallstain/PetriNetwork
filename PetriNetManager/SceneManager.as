package  PetriNetManager {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Scene;
	import PetriNetManager.State;
	import PetriNetManager.StateTransition;
	import PetriNetManager.ActionResult;
	import PetriNetManager.StatesUpdateEventHandler;
	
	/**
	* Основной класс библиотеки, представляющий собой менеджер для работы с сетью Петри.
	*/
	public class SceneManager extends EventDispatcher  {
		var sceneStates:Vector.<State> = new Vector.<State>();
		var sceneTransitions:Vector.<StateTransition> = new Vector.<StateTransition>();
		var history:Vector.<StateTransition> = new Vector.<StateTransition>();
		var currentHistoryPos = 0;
		
		/**
		* Возвращает вектор текущих состояний сети Петри
		*/
		public function get SceneStates(): Vector.<State> {
			return sceneStates;
		}
		
		/**
		* Возвращает историю переходов сети Петри
		*/
		public function get History(): Vector.<StateTransition> {
			return history;
		}
		
		/**
		* Возвращает текущую позицию в историю переходов
		*/
		public function get HistoryPosition(): int {
			return currentHistoryPos - 1;
		}
		
		/**
		* Конструктор по умолчанию
		*/
		public function SceneManager() {
		
		}		
		
		/**
		* Инициализирует сеть из JSON-файла
		*/
		public function initFromJSONFile(jsonFilePath: String){
			var TextFileLoader:URLLoader = new URLLoader();

			TextFileLoader.addEventListener(Event.COMPLETE, onLoaded);
			TextFileLoader.load(new URLRequest(jsonFilePath));

			function onLoaded(e:Event):void {
				var netData: Object = JSON.parse(e.target.data);
				initStates(netData);
				initTransitions(netData);
				dispatchEvent(new StatesUpdateEventHandler(StatesUpdateEventHandler.STATES_UPDATE_EVENT,sceneStates));
			}
		}
		
		/**
		* Инициализирует сеть из объекта (формат полей объекта аналогичен JSON)
		*/
		public function initFromObject(netData: Object){
				initStates(netData);
				initTransitions(netData);
				dispatchEvent(new StatesUpdateEventHandler(StatesUpdateEventHandler.STATES_UPDATE_EVENT,sceneStates));
		}
		
		private function initStates(netData: Object){
			var stateIds: Array = netData.states;
			var stateMarkers: Array = netData.markers;
			sceneStates = new Vector.<State>();
			for( var i = 0; i < stateIds.length; ++i){
				sceneStates.push(new State(stateIds[i],stateMarkers[i]));
			}
		}
		
		private function initTransitions(netData: Object){
			var transitions: Array = netData.transitions;
			var statesMap: Object = new Object();
			for each (var s in sceneStates ){
				statesMap[s.Id] = s;
			}
			sceneTransitions  = new Vector.<StateTransition>();
			for each (var t in transitions ){
				var inputStates = new Vector.<State>();
				var outputStates = new Vector.<State>();
				for each (var stateId in t.inputStates ){
					inputStates.push(statesMap[stateId.toString()]);
					
				}
				for each (stateId in t.outputStates ){
					outputStates.push(statesMap[stateId.toString()]);
				}
				
				sceneTransitions.push(new StateTransition(t.id,
										outputStates, inputStates));
			}
		}
		
		/**
		* Возвращает true, если переход с id, равным transitionId, является активным в данный момент
		*/
		public function isTransitionActive(transitionId: int){
			for each (var t in sceneTransitions ){
				if(t.Id === transitionId){
					return t.isActive();
				}
			}
			return false;
		}
		
		/**
		* Выполняет переход с id, равным transitionId
		*/
		public function makeAction(transitionId: int){
			for each (var t in sceneTransitions ){
				if(t.Id === transitionId){
					var result: ActionResult = t.executeTransition();
					dispatchEvent(new StatesUpdateEventHandler(StatesUpdateEventHandler.STATES_UPDATE_EVENT,sceneStates));
					if(result.isSuccessed()){
						addNewActionToHistory(t);
					}
					return result;
					break;
				}
			}
			return null;
		}
		
		/**
		* Выполняет первый активный переход с id, входящим в вектор transitionIds
		*/
		public function makeFirstActiveAction(transitionIds: Vector.<int>){
			for each (var tId in transitionIds ){
				var res: ActionResult = makeAction(tId);
				if(res.isSuccessed()){
					return res;
				}
			}
			return null;
		}
		
		/**
		* Выполняет переход назад по истории состояний сети Петри. Возвращает true, если переход был выполнен успешно
		*/
		public function stepBackwardInHistory(): Boolean{
			if(currentHistoryPos == 0){
				return false;
			}
			
			--currentHistoryPos;
			history[currentHistoryPos].redoTransition();
			dispatchEvent(new StatesUpdateEventHandler(StatesUpdateEventHandler.STATES_UPDATE_EVENT,sceneStates));
			return true;
		}
		
		/**
		* Выполняет переход вперед по истории состояний сети Петри. Возвращает true, если переход был выполнен успешно
		*/
		public function stepForwardInHistory(): Boolean{
			if(currentHistoryPos > history.length - 1){
				return false;
			}
			history[currentHistoryPos].executeTransition();
			++currentHistoryPos;
			dispatchEvent(new StatesUpdateEventHandler(StatesUpdateEventHandler.STATES_UPDATE_EVENT,sceneStates));
			return true;
		}		
		
		private function addNewActionToHistory(t: StateTransition){
			history = history.slice(0,currentHistoryPos);
			history.push(t);
			++currentHistoryPos;
		}
	}
	
}
