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
	import views.ConfigV;
	import views.UU.room.*;
	import views.UU.startup.InitRes_StateUU;
	import views.UU.startup.Startup_StateUU;
	
public class Initializer_web_board_student extends InitializerBase {
	
	override protected function registerViews() : void {
		super.registerViews();
		
		// room
		UUFacade.registerView("board",   StudentBoard_StateUU);
		UUFacade.registerView("video",   StudentVideo_StateUU);
	}
}
}