package
{
	import flash.display.Sprite;
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.logging.DebugLogger;
	import org.agony2d.logging.FlashTextLogger;
	import org.agony2d.logging.ILogger;
	
	[SWF(width = "1024", height = "600", frameRate="45", backgroundColor = "0xFFFFFF")]
	public class Main_air_board_student extends Sprite
	{
		public function Main_air_board_student()
		{
			var logger:FlashTextLogger;
			
			Agony.getLog().logger = logger = new FlashTextLogger(stage, false, 200, 300, 400);
			logger.visible = true;
			Agony.startup(1024, 600, new DesktopPlatform, stage, Initializer_web_board_student);
		}
	}
}