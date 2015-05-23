package test 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundCodec;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.*;
	
	public class FmsRecordTest extends Sprite 
	{
		public var nc_A:NetConnection;
		public var ns_A:NetStream;
		
		public var mic_A:Microphone;
		public var camera_A:Camera;
		
		public var fmsURL:String = "rtmp://112.74.101.8/agony/a";
		
		public function FmsRecordTest() 
		{
			this.nc_A = new NetConnection;
			this.nc_A.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_nc);
			this.nc_A.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			this.nc_A.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onIoError);
			this.nc_A.connect(fmsURL);
			
		}
		
		private function onIoError(e:Event):void {
			trace(e.type);
		}
		
		private function onNetStatus_nc(e:NetStatusEvent):void {
			trace("onNetStatus_nc", e.info.code);
			switch(e.info.code) {
				case "NetConnection.Connect.Success":
					this.____doStartRecord();
					break;
					
				case "NetConnection.Connect.Failed":
					
					break;
					
				default:
					break;
			}
			
			
			
			
		}
		
		private function ____doStartRecord():void {
			this.ns_A = new NetStream(this.nc_A);
			ns_A.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_ns);
			
			
			mic_A = Microphone.getMicrophone();
			//mic_A.encodeQuality = 0;
			//mic_A.codec = SoundCodec.NELLYMOSER;
			mic_A.setSilenceLevel(0);
			
			var st:SoundTransform = new SoundTransform;
			st.volume = 80;
			mic_A.soundTransform = st;
			
			//mic_A.setUseEchoSuppression(true);
			mic_A.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
			
			//mic_A.setLoopBack(true);
			
			this.ns_A.attachAudio(mic_A);
			
			camera_A = Camera.getCamera();
			camera_A.setMode(320, 240, 12);
			camera_A.setQuality(0, 80);
			this.ns_A.attachCamera(camera_A);
			
			this.ns_A.publish("mp4:AAA.f4v", "append");
			
		}
		
		private function onNetStatus_ns(e:NetStatusEvent):void {
			trace("onNetStatus_ns", e.info.code);
			
		}
		
		private function activityHandler(e:Event):void {
			trace("sound", e.type);
		}
	}

}