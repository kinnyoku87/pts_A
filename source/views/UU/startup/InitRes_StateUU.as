package views.UU.startup {
	import org.agony2d.events.AEvent;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.FilesBundle;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.ZipBundle;
	import org.agony2d.resource.handlers.FrameClip_BundleHandler;
	import org.agony2d.resource.handlers.TextureUU_BundleHandler;
	
	import resHandlers.ButtonUU_BundleHandler;
	import resHandlers.ProgressBarUU_BundleHandler;
	import resHandlers.Scale9ButtonUU_BundleHandler;
	import resHandlers.Scale9ToggleUU_BundleHandler;
	import resHandlers.Scale9UU_BundleHandler;
	import resHandlers.ToggleUU_BundleHandler;
	
public class InitRes_StateUU extends StateUU {
	
	override public function onEnter() : void {
		this.resA = new ResMachine("common/");
		
		// swf
		this.resA.addBundle(new FilesBundle("temp/swf/swfRes.swf"));
		
		// image
		this.resA.addBundle(new ZipBundle("demo.zip"), new TextureUU_BundleHandler);
		
		// frameClip（anime）
		this.resA.addBundle(new FilesBundle("data/frameClip_Ui.xml"), new FrameClip_BundleHandler);
		
		// scale9
		this.resA.addBundle(new FilesBundle("temp/scale9/scale9_C.png"), new Scale9UU_BundleHandler);
		
		// btn...combo
		this.resA.addBundle(new FilesBundle("temp/btn/combo/up.png", "temp/btn/combo/hover.png",
												"temp/btn/combo/down.png"), new TextureUU_BundleHandler, new ButtonUU_BundleHandler("combo"));
		
		// btn...A
		this.resA.addBundle(new FilesBundle("temp/btn/A/up.png", "temp/btn/A/hover.png",
								"temp/btn/A/down.png", "temp/btn/A/disabled.png"), new TextureUU_BundleHandler, new ButtonUU_BundleHandler("A"));
												
		// toggle...A
		this.resA.addBundle(new FilesBundle("temp/toggle/A/up.png", "temp/toggle/A/hover.png", 
								"temp/toggle/A/down.png", "temp/toggle/A/disabled.png",
								"temp/toggle/A/upA.png", "temp/toggle/A/hoverA.png", 
								"temp/toggle/A/downA.png", "temp/toggle/A/disabledA.png"), new TextureUU_BundleHandler, new ToggleUU_BundleHandler("A"));
								
		// radio...A
		this.resA.addBundle(new FilesBundle("temp/toggle/radio/up.png", "temp/toggle/radio/hover.png", 
								"temp/toggle/radio/down.png", "temp/toggle/radio/disabled.png",
								"temp/toggle/radio/upA.png", "temp/toggle/radio/hoverA.png", 
								"temp/toggle/radio/downA.png", "temp/toggle/radio/disabledA.png"), new TextureUU_BundleHandler, new ToggleUU_BundleHandler("radio"));
		
		// scale9Btn / scale9Toggle...A
		this.resA.addBundle(new FilesBundle("temp/btnScale9/A/up.png", "temp/btnScale9/A/hover.png",
												"temp/btnScale9/A/down.png", "temp/btnScale9/A/disabled.png"), new Scale9UU_BundleHandler, new Scale9ButtonUU_BundleHandler("A"), new Scale9ToggleUU_BundleHandler("A"));
		
		// progressBar...A
		this.resA.addBundle(new FilesBundle("temp/progressBar/01.png", "temp/progressBar/02.png","temp/progressBar/03.png"), new Scale9UU_BundleHandler, new ProgressBarUU_BundleHandler("A", 1));
		
												
		this.resA.addEventListener(AEvent.COMPLETE, onComplete);
	}
	
	public var resA:ResMachine;
	
	private function onComplete(e:AEvent):void {
		this.resA.removeAllListeners();
		
		this.getRoot().closeAllViews();
		
		
		this.getRoot().getView(this.getArg(0)).activate();
	}
}
}