package processors {
	import events.ASyncEvent;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;
	import org.agony2d.base.FrameManager;
	import org.agony2d.base.IPostUpdater;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.Notifier;
	
	import org.agony2d.base.inside.agony_internal;
	
	use namespace agony_internal;
	
	public class ARemoteSharedObject extends Notifier
	{
		
		public function ARemoteSharedObject( name:String, persistence:Object ) 
		{
			_sharedObject = SharedObject.getRemote(name, ConnectManager.getInstance().getNetConnect().uri, persistence);
			_sharedObject.connect(ConnectManager.getInstance().getNetConnect());
			_sharedObject.addEventListener(SyncEvent.SYNC, onSync);
		}
		
		
		public function getData() : Object {
			return _sharedObject.data;
		}
		
		public function setDirty( propertyName:String ) : void {
			_sharedObject.setDirty( propertyName );
		}
		
		
		
		private static var _syncEvent:ASyncEvent = new ASyncEvent(ASyncEvent.SYNC);
		
		private var _sharedObject:SharedObject;
		
		
		
		private function onSync(e:SyncEvent):void {
			_syncEvent.changeList = e.changeList;
			this.dispatchEvent(_syncEvent);
		}
	}
}