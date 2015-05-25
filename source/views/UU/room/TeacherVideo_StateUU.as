package views.UU.room 
{
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.net.NetStream;
	import org.agony2d.flashApi.StateUU;
	import processors.OutputStreamManager;
	/**
	 * ...
	 * @author ...
	 */
	public class TeacherVideo_StateUU extends StateUU
	{
		
		override public function onEnter() : void 
		{
			ns_A = OutputStreamManager.getInstance().getNetStream();
			
			mic_A = Microphone.getMicrophone();
			mic_A.setSilenceLevel(0);
			
			var st:SoundTransform = new SoundTransform;
			st.volume = 80;
			mic_A.soundTransform = st;
			this.ns_A.attachAudio(mic_A);
			
			camera_A = Camera.getCamera();
			camera_A.setMode(320, 240, 12);
			camera_A.setQuality(0, 80);
			this.ns_A.attachCamera(camera_A);
			
			this.ns_A.publish("mp4:AAA.f4v", "record");
			//this.ns_A.publish("mp4:AAA.f4v", "append");
		}
		
		
		public var ns_A:NetStream;
		public var mic_A:Microphone;
		public var camera_A:Camera;
		
		
	}

}