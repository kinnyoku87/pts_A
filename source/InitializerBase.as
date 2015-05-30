package {
	import flash.display.Stage;
	import flash.system.Security;
	import flash.ui.Keyboard;
	import org.agony2d.Agony;
	import org.agony2d.core.Adapter;
	import org.agony2d.core.IInitializer;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.AKeyboardEvent;
	import org.agony2d.flashApi.RootUU;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.utils.gc;
	import processors.ConnectManager;
	import views.ConfigV;
	import views.UU.room.*;
	import views.UU.startup.InitRes_StateUU;
	import views.UU.startup.Startup_StateUU;
	
public class InitializerBase implements IInitializer {
	
	private var _adapter:Adapter;
	private var _rootUU:RootUU;
	private var _viewIdList:Array;
	
	public function onInit( stage:Stage ) : void {
//		Security.allowDomain("*");
		
		this._adapter = Agony.createAdapter(stage);
		
		ResMachine.activate(AtlasAssetConvert);
		
		_rootUU = UUFacade.createRoot(this._adapter);
		this.registerViews();
		
		ConnectManager.getInstance().connect();
		
		ConnectManager.getInstance().addEventListener(AEvent.COMPLETE, onConnected);
		this._adapter.getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, ____onKeyboardForDebug);
	}
	
	protected function registerViews() : void {
		UUFacade.registerView("startup", Startup_StateUU);
		UUFacade.registerView("initRes", InitRes_StateUU);
	}
	
	private function onConnected(e:AEvent):void {
		ConnectManager.getInstance().removeEventListener(AEvent.COMPLETE, onConnected);
		
		_viewIdList = [];
		_viewIdList.push("board");
		if (ConfigV.videoEnabled) {
			_viewIdList.push("video");
		}
		_rootUU.getView("startup").activate();
		_rootUU.getView("initRes").activate([____activateViews]);
	}
	
	private function ____onKeyboardForDebug(e:AKeyboardEvent):void {
		if (e.keyCode == Keyboard.G) {
			gc();
		}
		else if (e.keyCode == Keyboard.R) {
			this.____activateViews();
		}
	}
	
	private function ____activateViews() : void {
		var i:int;
		var l:int;
		
		_rootUU.closeAllViews();
		l = _viewIdList.length;
		while (i < l) {
			_rootUU.getView(_viewIdList[i++]).activate();
		}
	}
}
}