# PetriNetwork
PetriNetwork - библиотека на ActionScript 3, моделирующая функционирование сети Петри. Разработана для создания интерактивной Flash-анимации в обучающей среде Гипертест 

## Теоретические основы

Сеть Петри представляет собой двудольный ориентированный мультиграф, состоящий из вершин двух типов — позиций и переходов, соединённых между собой дугами. Вершины одного типа не могут быть соединены непосредственно. В позициях могут размещаться метки (маркеры), способные перемещаться по сети.
![alt-текст](https://upload.wikimedia.org/wikipedia/commons/f/fe/Detailed_petri_net.png )

Событием называют срабатывание перехода, при котором метки из входных позиций этого перехода перемещаются в выходные позиции. События происходят мгновенно, либо разновременно, при выполнении некоторых условий.

## Использование:
1. Создать новый ролик в среде Flash
2. Добавить файлы библиотеки в директорию с роликом
1. Создать скрип ролика и импортировать в него использованные библиотеки следующи образом
```javascript
import PetriNetManager.State;
import PetriNetManager.StateTransition;
import PetriNetManager.ActionResult;
import PetriNetManager.SceneManager;
import PetriNetManager.StatesUpdateEventHandler;
import flash.display.DisplayObject;
```
4. Создать объект, отвечающий за интерпретацию сети Петри
```javascript
var sceneMgr = new SceneManager();
```
5. Создать фон и управляемые объекты в ролике в виде фрагментов ролика
   * Рекомендуется расположить различные фоновые изображения в разных кадрах одного фрагмента ролика. Переключение кадров следует остановить командой stop(); в каждом кадре
6. Создать объект модели сети Петри вида:
```javascript
var sett:Object = {
    //Номера позиций
    states: [1,2,3,4,5],
    //Есть ли в позиции маркер
    markers: [1,0,0,0,0],
    //Массив объектов переходов
    transitions:[{
    		//номер перехода
		id: 1,
		//Входные позиции
		inputStates:[1],
		//Выходные позиции
		outputStates:[2]
	},
	{
		id: 2,
		inputStates:[2],
		outputStates:[3]
	},
	{
		id: 3,
		inputStates:[1],
		outputStates:[5]
	}
	] 
};
```
7. Инициализировать объект сети Петри 
```javascript
sceneMgr.initFromObject(sett);
```
8. Назначить управляющим объектам обработчики событий, в которых вызвать метод makeAction() для нужного перехода
```javascript
helpBtn.addEventListener(MouseEvent.CLICK, helpBtnInvoke);
function helpBtnInvoke(e:MouseEvent):void {
	sceneMgr.makeAction(1);
}

```

9. Назначить обработчик события осуществления перехода и назначить действия для каждого перехода
```javascript
function statesChangedHandler(e:StatesUpdateEventHandler){

	for each (var s:State in e.States){
		trace(s.Id + " " + s.hasMarkers());
	}
	trace ("-----------------------------");
	
	//Если срабатывает первый переход
	if(e.States[0].hasMarkers()){
		//переходим на другой фон
		bg1.gotoAndStop(1);
		//меняем текст в навигационном окне
		curStr = "Зайдите в меню HELP или нажмите CTRL+SHIFT+D";
		
	}
	if(e.States[1].hasMarkers()){
		bg1.gotoAndStop(2);
		curStr = "Выберите пункт Default Keymap Reference";

		
	}
	if(e.States[2].hasMarkers()){
		bg1.gotoAndStop(3);
		curStr = "Список со всеми горячими клавишами";
	}
	if(e.States[4].hasMarkers()){
		bg1.gotoAndStop(4);
		curStr = "Форма поиска команды";
		
		
	}
}
sceneMgr.addEventListener(StatesUpdateEventHandler.STATES_UPDATE_EVENT, statesChangedHandler);	
```
10. Анимация готова!

## Заметки:
* В репозитории хранится тестовый ролик lab1.fla, примеры кода взяты из него
* В качестве обработчиков событий могут быть использованы любые поддерживаемые Flash события
* При создании фрагментов роликов, не забудте присваивать им имена реализации!
