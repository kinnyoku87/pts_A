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
	import processors.InputStreamManager;
	import processors.OutputStreamManager;
	/**
	 * ...
	 * @author ...
	 */
	public class StudentVideo_StateUU extends StateUU
	{
		
		override public function onEnter() : void 
		{
			// Input
			/*ns_input = InputStreamManager.getInstance().getNetStream();
			
			mic_A = Microphone.getMicrophone();
			mic_A.setSilenceLevel(0);
			
			var st:SoundTransform = new SoundTransform;
			st.volume = 80;
			mic_A.soundTransform = st;
			this.ns_input.attachAudio(mic_A);
			
			camera_A = Camera.getCamera();
			camera_A.setMode(320, 240, 12);
			camera_A.setQuality(0, 80);
			this.ns_input.attachCamera(camera_A);
			
			this.ns_input.publish("mp4:student.f4v", "record");*/
			
			// Output
			ns_output = OutputStreamManager.getInstance().getNetStream();
			
			_rawSprite = new RawSpriteUU;
			this.getFusion().addNode(_rawSprite);
			
			this.video_A = new Video(320, 240);
			_rawSprite.addChild(this.video_A);
			
			this.client = new Object;
			ns_output.client = this.client;
			ns_output.play("mp4:teacher.f4v");
			
			
			this.video_A.attachNetStream(this.ns_output);
			
		}
		
		public var ns_input:NetStream;
		public var ns_output:NetStream;
		
		public var mic_A:Microphone;
		public var camera_A:Camera;
		
		public var video_A:Video;
		public var client:Object;
		
		private var _rawSprite:RawSpriteUU;
	}

}