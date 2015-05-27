package processors {
	
	/**
	 * 远程共享管理器
	 */
public class RemoteManager 
{
	
	public static const DRAWING:String = "drawing";
	
	private static var _instance:RemoteManager;
	public static function getInstance() : RemoteManager {
		return _instance ||= new RemoteManager;
	}
	
	public function getDrawing() : ARemoteSharedObject {
		return _drawingObj ||= new ARemoteSharedObject(DRAWING, false);
	}
	
	
	
	
	private var _drawingObj:ARemoteSharedObject;
}
}