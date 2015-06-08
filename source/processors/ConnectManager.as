package processors {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.NetConnection;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import org.agony2d.Agony;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.ErrorEvent;
	import org.agony2d.events.Notifier;
	
public class ConnectManager extends Notifier {
	
	private static var _instance:ConnectManager;
	public static function getInstance() : ConnectManager {
		return _instance ||= new ConnectManager;
	}
	
	public function getNetConnect() : NetConnection {
		return _ncA;
	}
	
	public function connect() : void {
		if (_ncA && _ncA.connected) {
			return;
		}
		_ncA = new NetConnection;
		_ncA.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_nc);
		_ncA.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onError);
		_ncA.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
		_ncA.connect(ConfigP.fmsBaseURL);
	}
	
	public function close() : void {
		if (!_ncA || !_ncA.connected) {
			return;
		}
		_ncA.close();
	}
	
	
	private var _ncA:NetConnection;
	private var _reconnectTotal:int = 5;
	
	
	
	private function onNetStatus_nc(e:NetStatusEvent):void {
		Agony.getLog().message(this, "连接状态: {0}", e.info.code);
		
		switch(e.info.code) {
			case "NetConnection.Connect.Success":
				this.dispatchDirectEvent(AEvent.COMPLETE);
				break;
				
			default:
				break;
		}
	}
	
	private function onError(e:Event):void {
		trace(e.type);
	}
	
	private function onIoError(e:IOErrorEvent):void {
		if (_reconnectTotal-- > 0) {
			_ncA.connect(ConfigP.fmsBaseURL);
		}
	}
}
}