package test 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetDataEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.ui.Keyboard;
	import org.agony2d.Agony;
	import org.agony2d.crossing.Adapter;
	import org.agony2d.crossing.DesktopPlatform;
	import org.agony2d.events.AKeyboardEvent;
	
	public class FmsVideoTest extends Sprite 
	{
		public var nc_A:NetConnection;
		public var ns_A:NetStream;
		
		public var mic_A:Microphone;
		public var camera_A:Camera;
		
		public var video_A:Video;
		
		public var client:Object;
		
		public var fmsURL:String = "rtmp://112.74.101.8/agony/a";
		
		public var adapter:Adapter;
		
		public function FmsVideoTest() 
		{
			this.nc_A = new NetConnection;
			this.nc_A.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_nc);
			this.nc_A.connect(fmsURL);
			
			Agony.startup(1024, 768, new DesktopPlatform, stage, null);
			adapter = Agony.createAdapter(stage);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			trace(e);
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void {
			trace(e);
		}
		
		private function onNetStatus_nc(e:NetStatusEvent):void {
			trace("onNetStatus_nc", e.info.code);
			switch(e.info.code) {
				case "NetConnection.Connect.Success":
					this.____doStartPlay();
					break;
					
				case "NetConnection.Connect.Failed":
					
					break;
					
				default:
					break;
			}
			
			
		}
		
		private function ____doStartPlay():void {
			this.ns_A = new NetStream(this.nc_A);
			
			//this.ns_A = new NetStream(this.nc_A);
			ns_A.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_ns);
			ns_A.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns_A.addEventListener(IOErrorEvent.IO_ERROR, onNsEvent);
			ns_A.addEventListener(NetDataEvent.MEDIA_TYPE_DATA, onNetData);
			
			// 这个client不加会报错！！待解..
			this.client = new Object;
			ns_A.client = this.client;
			ns_A.play("mp4:AAA.f4v");
			this.video_A = new Video(320, 240);
			this.addChild(this.video_A);
			//this.video_A
			
			var st:SoundTransform = new SoundTransform;
			st.volume = 80;
			ns_A.soundTransform = st;
			
			this.video_A.attachNetStream(this.ns_A);
			
			this.adapter.getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, onKeyDown);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onNetStatus_ns(e:NetStatusEvent):void {
			trace("onNetStatus_ns", e.info.code);
			
		}
		
		private function onNsEvent(e:Event):void {
			trace("ns", e.type);
		}
		
		private function onNetData(e:NetDataEvent):void {
			trace("netData", e.type);
		}
		
		private function onEnterFrame(e:Event):void {
			trace(ns_A.time, ns_A.bytesLoaded, ns_A.bytesTotal);
		}
		
		private function onKeyDown(e:AKeyboardEvent):void {
			switch(e.keyCode) {
				case Keyboard.A:
					ns_A.seek(ns_A.time - 3);
					break;
				case Keyboard.D:
					ns_A.seek(ns_A.time + 3);
					break;
				case Keyboard.O:
					ns_A.seek(0);
					break;
			}
		}
	}

}