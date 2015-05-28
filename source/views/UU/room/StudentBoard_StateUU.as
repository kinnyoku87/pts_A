package views.UU.room {
	import events.ASyncEvent;
	import flash.ui.Keyboard;
	import models.drawing.CommonPaper;
	import models.drawing.DrawingManager;
	import models.drawing.DrawingPlayer2;
	import models.drawing.IBrush;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.agony2d.Agony;
	import org.agony2d.events.AKeyboardEvent;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.flashApi.ImageUU;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.flashApi.ImageLoaderUU;
	import org.agony2d.flashApi.MultiStateUU;
	import org.agony2d.flashApi.textures.TextureUU;
	import org.agony2d.flashApi.UUFacade;
	import processors.ARemoteSharedObject;
	import processors.RemoteManager;
	
public class StudentBoard_StateUU extends StateUU {
	
	override public function onEnter() :void {
		var textureUU:TextureUU;
		var BA:BitmapData;
		
		_drawingRemote = RemoteManager.getInstance().getDrawing();
		
		_paper = DrawingManager.getInstance().paper;
		_paper.reset();
		
		_player = new DrawingPlayer2(_paper);
		
		// 白板背景图片
		_imageLoader = new ImageLoaderUU;
		this.getFusion().addNode(_imageLoader);
		_imageLoader.load("1.jpg", false);
		
		// 绘制图片
		_imageA = new ImageUU;
		this.getFusion().addNode(_imageA);
		_imageA.textureId = "currWhiteBoard";
		
		// event listeners
		this.getFusion().insertEventListener(_drawingRemote, ASyncEvent.SYNC, onSync);
	}
	
	
	
	public var _paper:CommonPaper;
	private var _player:DrawingPlayer2;
	
	private var _imageLoader:ImageLoaderUU;
	private var _imageA:ImageUU;
	private var _drawingRemote:ARemoteSharedObject;
	
	
	
	private function onSync(e:ASyncEvent):void {
		var AY:Array;
		
		if (!_drawingRemote.getData()["A"]) {
			return;
		}
		AY = _drawingRemote.getData()["A"];
		//Agony.getLog().simplify("student: " + AY.length / 12);
		
		this._player.drawData(AY);
	}
}
}