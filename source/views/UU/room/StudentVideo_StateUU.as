package views.UU.room 
{
	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetStream;
	import org.agony2d.flashApi.flash.RawSpriteUU;
	import org.agony2d.flashApi.StateUU;
	import processors.OutputStreamManager;
	/**
	 * ...
	 * @author ...
	 */
	public class StudentVideo_StateUU extends StateUU
	{
		
		override public function onEnter() : void 
		{
			ns_A = OutputStreamManager.getInstance().getNetStream();
			
			_rawSprite = new RawSpriteUU;
			this.getFusion().addNode(_rawSprite);
			
			this.video_A = new Video(320, 240);
			_rawSprite.addChild(this.video_A);
			
			this.client = new Object;
			ns_A.client = this.client;
			ns_A.play("mp4:AAA.f4v");
			//ns_A.play("raw:AAA");
			
			
			this.video_A.attachNetStream(this.ns_A);
			
		}
		
		public var ns_A:NetStream;
		
		public var video_A:Video;
		
		public var client:Object;
		
		private var _rawSprite:RawSpriteUU;
	}

}