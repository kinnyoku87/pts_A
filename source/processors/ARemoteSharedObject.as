package processors 
{
	import events.ASyncEvent;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;
	import org.agony2d.base.FrameManager;
	import org.agony2d.base.IPostUpdater;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.Notifier;
	
	import org.agony2d.base.inside.agony_internal;
	
	use namespace agony_internal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ARemoteSharedObject extends Notifier// implements IPostUpdater
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
			//if (_dirtyMap[propertyName] || !_syncCompleted) {
				//return;
			//}
			//_dirtyMap[propertyName] = propertyName;
			//this.____doAddToPostUpdateList();
			_sharedObject.setDirty( propertyName );
		}
		
		
		
		private static var _syncEvent:ASyncEvent = new ASyncEvent(ASyncEvent.SYNC);
		
		private var _sharedObject:SharedObject;
		//private var _isPostUpdating:Boolean;
		//private var _dirtyMap:Object = [];
		//private var _syncCompleted:Boolean = true;
		
		
		//private function ____doAddToPostUpdateList() : void {
			//if (!_isPostUpdating) {
				//FrameManager.doAddPostUpdateObject(this);
				//_isPostUpdating = true;
			//}
		//}
		
		//public function onPostUpdate():void {
			//var propertyName:String;
			//
			//for each(propertyName in _dirtyMap) {
				//if (_sharedObject.data[propertyName] as Array) {
					//_sharedObject.data[propertyName] = (_sharedObject.data[propertyName] as Array).concat();
				//}
				//_sharedObject.setDirty( propertyName );
				//delete _dirtyMap[propertyName];
			//}
			//
			//_isPostUpdating = false;
			//
			//this.dispatchDirectEvent(AEvent.COMPLETE);
		//}
		
		private function onSync(e:SyncEvent):void {
			//_syncCompleted = true;
			
			_syncEvent.changeList = e.changeList;
			this.dispatchEvent(_syncEvent);
			
			//trace("change");
			
		}
	}
}