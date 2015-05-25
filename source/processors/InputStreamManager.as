package processors 
{
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.net.NetStream;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	
	// 输入流管理器，录制视频音频等.
public class InputStreamManager 
{
	
	public function InputStreamManager() 
	{
		
	}
	
	private static var _instance:InputStreamManager;
	public static function getInstance() : InputStreamManager {
		return _instance ||= new InputStreamManager;
	}
	
	public function getNetStream() : NetStream {
		var st:SoundTransform;
		
		if (!_nsA) {
			_nsA = new NetStream(ConnectManager.getInstance().getNetConnect());
			_nsA.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_ns);
			_nsA.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			
			_client = new Object;
			_nsA.client = _client;
			
			st = new SoundTransform;
			st.volume = 80;
			_nsA.soundTransform = st;
		}
		return _nsA;
	}
	
	
	private var _nsA:NetStream;
	private var _client:Object;
	
	
	private function onNetStatus_ns(e:NetStatusEvent):void {
		trace("onNetStatus_ns", e.info.code);
		
	}
	
	private function onNsEvent(e:Event):void {
		trace("ns", e.type);
	}
}
}