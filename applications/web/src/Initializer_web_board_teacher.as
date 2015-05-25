package {
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import org.agony2d.crossing.Adapter;
	import org.agony2d.flashApi.RootUU;
	import views.UU.room.TeacherRoom_StateUU;
	import views.UU.startup.InitRes_StateUU;
	import views.UU.startup.Startup_StateUU;
	
	import UU.ShowUI_StateUU;
	import UU.loading.LoadingResUI_StateUU;
	
	import org.agony2d.Agony;
	import org.agony2d.crossing.IInitializer;
	import org.agony2d.events.AKeyboardEvent;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	import org.agony2d.resource.converters.SwfClassAssetConverter;
	import org.agony2d.utils.Stats;
	import org.agony2d.utils.gc;
	
public class Initializer_web_board_teacher implements IInitializer {
	
	private var _adapter:Adapter;
	private var _rootUU:RootUU;
	
	public function onInit( stage:Stage ) : void {
		//stage.addChild(new Stats(0, 20));
		
		//stage.quality = StageQuality.LOW;
		//stage.quality = StageQuality.MEDIUM
		//stage.quality = StageQuality.HIGH;
		
		this._adapter = Agony.createAdapter(stage);
		
		ResMachine.activate(AtlasAssetConvert);
		
		UUFacade.registerView("startup", Startup_StateUU);
		UUFacade.registerView("initRes", InitRes_StateUU);
		UUFacade.registerView("room",    TeacherRoom_StateUU);
		
		_rootUU = UUFacade.createRoot(this._adapter);
		
		_rootUU.getView("startup").activate();
		_rootUU.getView("initRes").activate(["room"]);
		
		this._adapter.getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, ____onKeyboardForDebug);
	}
	
	private function ____onKeyboardForDebug(e:AKeyboardEvent):void {
		if (e.keyCode == Keyboard.G) {
			gc();
		}
	}
}
}