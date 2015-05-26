package processors {
	
	/**
	 * 远程共享管理器
	 */
public class RemoteManager 
{
	
	public function RemoteManager() {
		_drawingObj = getRemote("drawing");
	}
	
	
	private static var _instance:RemoteManager;
	public static function getInstance() : RemoteManager {
		return _instance ||= new RemoteManager;
	}
	
	public function getRemote( name:String ) : ARemoteSharedObject {
		return _remoteSharedObjList[name] ||= new ARemoteSharedObject(name);
	}
	
	public function getDrawing() : ARemoteSharedObject {
		return _drawingObj;
	}
	
	
	
	
	private static var _remoteSharedObjList:Object = { };
	private var _drawingObj:ARemoteSharedObject;
}
}