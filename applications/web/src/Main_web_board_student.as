package
{
	import flash.display.Sprite;
	import org.agony2d.Agony;
	import org.agony2d.crossing.DesktopPlatform;
	import org.agony2d.logging.DebugLogger;
	
	[SWF(width = "1024", height = "600", frameRate="45", backgroundColor = "0xFFFFFF")]
	public class Main_web_board_student extends Sprite
	{
		public function Main_web_board_student()
		{
			Agony.getLog().logger = new DebugLogger();
			Agony.startup(1024, 600, new DesktopPlatform, stage, Initializer_web_board_student);
		}
	}
}