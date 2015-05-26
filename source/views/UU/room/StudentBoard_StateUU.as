package views.UU.room {
	import events.ASyncEvent;
	import flash.ui.Keyboard;
	import models.drawing.CommonPaper;
	import models.drawing.DrawingManager;
	import models.drawing.IBrush;
	import flash.display.BitmapData;
	import flash.display.Shape;
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
		_drawingRemote.addEventListener(ASyncEvent.SYNC, onSync);
		
		this.paper = DrawingManager.getInstance().paper;
		//this.paper.currBrush.color = 0x0;
		this.paper.reset();
		
		// 白板背景图片
		_imageLoader = new ImageLoaderUU;
		this.getFusion().addNode(_imageLoader);
		_imageLoader.load("1.jpg", false);
		
		// 绘制图片
		_imageA = new ImageUU;
		this.getFusion().addNode(_imageA);
		_imageA.textureId = "currWhiteBoard";
		
		this.getRoot().getAdapter().getTouch().addEventListener(ATouchEvent.PRESS,   ____onPress, 100000);
		this.getRoot().getAdapter().getTouch().addEventListener(ATouchEvent.MOVE,    ____onMove, 100000);
		this.getRoot().getAdapter().getTouch().addEventListener(ATouchEvent.RELEASE, ____onRelease, 100000);
		
		this.getRoot().getAdapter().getKeyboard().addEventListener(AKeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	
	public var paper:CommonPaper;
	
	private var _imageLoader:ImageLoaderUU;
	private var _imageA:ImageUU;
	
	
	private function ____onPress(e:ATouchEvent):void {
		this.paper.startDraw(e.touch.rootX, e.touch.rootY);
	}
	
	private function ____onMove(e:ATouchEvent):void {
		if (e.touch.isPressed()) {
			this.paper.drawLine(e.touch.rootX, e.touch.rootY, e.touch.prevRootX, e.touch.prevRootY);
			
			
			
		}
	}
	
	private var _drawingRemote:ARemoteSharedObject;
	
	private function onSync(e:ASyncEvent):void {
		trace(_drawingRemote.getData()["A"]);
	}
	
	private function ____onRelease(e:ATouchEvent):void {
		this.paper.endDraw();
	}
	
	private function onKeyDown(e:AKeyboardEvent):void {
		switch(e.keyCode) {
			case Keyboard.NUMBER_1:
				this.paper.brushIndex = 0;
				break;
			case Keyboard.NUMBER_2:
				this.paper.brushIndex = 1;
				break;
			case Keyboard.NUMBER_3:
				this.paper.brushIndex = 2;
				break;
			case Keyboard.NUMBER_4:
				this.paper.brushIndex = 3;
				break;
			case Keyboard.NUMBER_5:
				this.paper.brushIndex = 4;
				break;
			case Keyboard.NUMBER_6:
				this.paper.brushIndex = 5;
				break;
		}
	}
}
}