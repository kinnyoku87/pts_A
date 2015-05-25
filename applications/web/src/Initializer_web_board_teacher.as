package {
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import org.agony2d.Agony;
	import org.agony2d.crossing.Adapter;
	import org.agony2d.crossing.IInitializer;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.AKeyboardEvent;
	import org.agony2d.flashApi.RootUU;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.utils.gc;
	import processors.ConnectManager;
	import views.UU.room.*;
	import views.UU.startup.InitRes_StateUU;
	import views.UU.startup.Startup_StateUU;
	
public class Initializer_web_board_teacher implements IInitializer {
	
	private var _adapter:Adapter;
	private var _rootUU:RootUU;
	
	public function onInit( stage:Stage ) : void {
		this._adapter = Agony.createAdapter(stage);
		this._adapter.getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, ____onKeyboardForDebug);
		
		ResMachine.activate(AtlasAssetConvert);
		
		UUFacade.registerView("startup", Startup_StateUU);
		UUFacade.registerView("initRes", InitRes_StateUU);
		// room
		UUFacade.registerView("board",   TeacherBoard_StateUU);
		UUFacade.registerView("video",   TeacherVideo_StateUU);
		
		_rootUU = UUFacade.createRoot(this._adapter);
		
		ConnectManager.getInstance().addEventListener(AEvent.COMPLETE, onConnected);
		ConnectManager.getInstance().connect();
	}
	
	private function onConnected(e:AEvent):void {
		ConnectManager.getInstance().removeEventListener(AEvent.COMPLETE, onConnected);
		
		_rootUU.getView("startup").activate();
		_rootUU.getView("initRes").activate(["board", "video"]);
	}
	
	
	private function ____onKeyboardForDebug(e:AKeyboardEvent):void {
		if (e.keyCode == Keyboard.G) {
			gc();
		}
	}
}
}