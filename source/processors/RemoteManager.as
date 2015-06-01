package processors {
	
	/**
	 * 远程共享管理器
	 */
public class RemoteManager {
	
	//////////////////////////
	// shared object names
	//////////////////////////
	public static const DRAWING:String = "drawing";
	
	
	
	private static var _instance:RemoteManager;
	public static function getInstance() : RemoteManager {
		return _instance ||= new RemoteManager;
	}
	
	public function getIdleDrawing() : ARemoteSharedObject {
		var i:int;
		var l:int;
		var remote:ARemoteSharedObject;
		
		l = _drawingObjList.length;
		while (i < l) {
			remote = _drawingObjList[i++];
			if (remote.isReady) {
				return remote;
			}
		}
		return null;
	}
	
	public function getDrawingList() : Vector.<ARemoteSharedObject> {
		if (!_drawingObjList) {
			_drawingObjList = new <ARemoteSharedObject>[];
			_drawingObjList.push(new ARemoteSharedObject(DRAWING + "0", false));
			_drawingObjList.push(new ARemoteSharedObject(DRAWING + "1", false));
			_drawingObjList.push(new ARemoteSharedObject(DRAWING + "2", false));
		}
		return _drawingObjList;
	}
	
	
	
	
	private var _drawingObjList:Vector.<ARemoteSharedObject>;
}
}