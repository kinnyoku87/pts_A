package {
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import org.agony2d.crossing.Adapter;
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
	
public class Initializer_web_board_student implements IInitializer {
	
	private var _adapter:Adapter;
	
	public function onInit( stage:Stage ) : void {
		//stage.addChild(new Stats(0, 20));
		
		//stage.quality = StageQuality.LOW;
		//stage.quality = StageQuality.MEDIUM
		//stage.quality = StageQuality.HIGH;
		
		this._adapter = Agony.createAdapter(stage);
		
		ResMachine.activate(AtlasAssetConvert);
		
		UUFacade.registerView("startup", Startup_StateUU);
		UUFacade.registerView("initRes", InitRes_StateUU);
		
		UUFacade.createRoot(this._adapter).getView("initRes").activate(["startup"]);
		
		this._adapter.getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, ____onKeyboardForDebug);
	}
	
	private function ____onKeyboardForDebug(e:AKeyboardEvent):void {
		if (e.keyCode == Keyboard.G) {
			gc();
		}
	}
}
}