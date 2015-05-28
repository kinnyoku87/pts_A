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
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.*;
	import flash.net.SharedObject;
	import flash.ui.Keyboard;
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.events.AKeyboardEvent;
	
	public class RemoteSharedObjectTest extends Sprite
	{
		
		public function RemoteSharedObjectTest() 
		{
			
			this.nc_A = new NetConnection;
			this.nc_A.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_nc);
			this.nc_A.connect(fmsURL);
			
		}
		
		
		public var nc_A:NetConnection;
		public var ns_A:NetStream;
		
		public var mic_A:Microphone;
		public var camera_A:Camera;
		
		public var fmsURL:String = "rtmp://112.74.101.8/agony/a";
		
		public var video_A:Video;
		
		public var _sharedObject:SharedObject;
		
		
		
		private function onNetStatus_nc(e:NetStatusEvent):void {
			trace("onNetStatus_nc", e.info.code);
			switch(e.info.code) {
				case "NetConnection.Connect.Success":
					
					break;
					
				case "NetConnection.Connect.Failed":
					
					break;
					
				default:
					break;
			}
			
			
			_sharedObject = SharedObject.getRemote("test", nc_A.uri, false);
			_sharedObject.connect(nc_A);
			_sharedObject.addEventListener(SyncEvent.SYNC, onSync);
			
			//_sharedObject.data["A"] = 1;
			//_sharedObject.setDirty("A");
			//_sharedObject.data["A"] = 2;
			//_sharedObject.setDirty("A");
			//_sharedObject.data["A"] = 3;
			//_sharedObject.data["A"] = 4;
			
			Agony.startup(1111, 1111, new DesktopPlatform, stage, null);
			
			Agony.createAdapter(stage).getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:AKeyboardEvent):void {
			if (e.keyCode == Keyboard.D) {
				if (!_sharedObject.data["A"]) {
					_sharedObject.data["A"] = 1;
				}
				else {
					_sharedObject.data["A"] = 1;
				}
				_sharedObject.setDirty("A");
			}
		}
		
		private var _syncCompleted:Boolean;
		
		private function onSync(e:SyncEvent):void {
			trace(_sharedObject.data["A"]);
			
			_syncCompleted = true;
		}
		
	}

}