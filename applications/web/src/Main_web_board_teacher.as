package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.logging.DebugLogger;
	import org.agony2d.logging.FlashTextLogger;
	
	[SWF(width = "1024", height = "600", frameRate="45", backgroundColor = "0xFFFFFF")]
	public class Main_web_board_teacher extends Sprite
	{
		public function Main_web_board_teacher()
		{
			var logger:FlashTextLogger;
			
			Agony.getLog().logger = logger = new FlashTextLogger(stage, false, 200, 500, 400);
			logger.visible = true;
			Agony.startup(1024, 600, new DesktopPlatform, stage, Initializer_web_board_teacher);
			//rawStage = stage;
		}
		
		//public static var rawStage:Stage;
	}
}