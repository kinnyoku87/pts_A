package processors {
	import events.ASyncEvent;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;
	import org.agony2d.ticking.TickManager;
	import org.agony2d.ticking.IPostUpdater;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.Notifier;
	
	import org.agony2d.core.inside.agony_internal;
	
	use namespace agony_internal;
	
	public class ARemoteSharedObject extends Notifier
	{
		
		public function ARemoteSharedObject( name:String, persistence:Object ) 
		{
			_sharedObject = SharedObject.getRemote(name, ConnectManager.getInstance().getNetConnect().uri, persistence);
			_sharedObject.connect(ConnectManager.getInstance().getNetConnect());
			_sharedObject.addEventListener(SyncEvent.SYNC, onSync);
		}
		
		public var isReady:Boolean;
		
		public function getData() : Object {
			return _sharedObject.data;
		}
		
		public function setDirty( propertyName:String ) : void {
			_sharedObject.setDirty( propertyName );
			isReady = false;
		}
		
		
		
		private static var _syncEvent:ASyncEvent = new ASyncEvent(ASyncEvent.SYNC);
		
		private var _sharedObject:SharedObject;
		
		
		
		private function onSync(e:SyncEvent):void {
			isReady = true;
			_syncEvent.changeList = e.changeList;
			this.dispatchEvent(_syncEvent);
		}
	}
}