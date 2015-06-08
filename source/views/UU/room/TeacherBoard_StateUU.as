package views.UU.room {
	import events.ASyncEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import models.drawing.CommonPaper;
	import models.drawing.DrawingManager;
	import models.drawing.IBrush;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.agony2d.Agony;
	import org.agony2d.events.AdapterEvent;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.AKeyboardEvent;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.events.TickEvent;
	import org.agony2d.flashApi.FusionUU;
	import org.agony2d.flashApi.ImageUU;
	import org.agony2d.flashApi.StateFusionUU;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.flashApi.ImageLoaderUU;
	import org.agony2d.flashApi.textures.TextureUU;
	import org.agony2d.flashApi.UUFacade;
	import processors.ARemoteSharedObject;
	import processors.RemoteManager;
	import views.ConfigV;
	
public class TeacherBoard_StateUU extends StateUU {
	
	override public function onEnter() : void {
		var textureUU:TextureUU;
		var BA:BitmapData;
		
		this.getFusion().spaceHeight = this.getRoot().getAdapter().rootHeight;
		
		this.doInitDrawingRemote();
		
		_paper = DrawingManager.getInstance().paper;
		_paper.reset();
		
		_boardFusion = new FusionUU;
		this.getFusion().addNode(_boardFusion);
		_boardFusion.touchable = false;
		
		// 白板背景图片
		_imageLoader = new ImageLoaderUU;
		_boardFusion.addNode(_imageLoader);
		_imageLoader.load("1.jpg", false);
		
		// 绘制图片
		_imageA = new ImageUU;
		_boardFusion.addNode(_imageA);
		_imageA.textureId = "currWhiteBoard";
		
		if (ConfigV.brushPanel) {
			_fusionBottom = this.createStateFusion(Brush_StateUU);
			_fusionBottom.x = -50;
		}
		
		
		// event listener
		this.getFusion().insertEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.PRESS,   ____onPress,   100);
		//this.getFusion().insertEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.MOVE,    ____onMove,    100);
		//this.getFusion().insertEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.RELEASE, ____onRelease, 100);
		//this.getFusion().insertEventListener(this.getRoot().getAdapter().getKeyboard(), AKeyboardEvent.KEY_DOWN, onKeyDown);
		
		this.getFusion().insertEventListener(Agony.getTick(), TickEvent.TICKING, onTicking);
		this.getFusion().insertEventListener(this.getRoot().getAdapter(), AdapterEvent.ROOT_RESIZE, onRootResize, 50);
	}
	
	private var _fusionBottom:FusionUU;
	private var _boardFusion:FusionUU;
	
	private function onRootResize(e:AdapterEvent):void {
		this.getFusion().spaceHeight = this.getRoot().getAdapter().rootHeight;
		//trace(this.getFusion().spaceHeight);
	}
	
	private function doInitDrawingRemote() : void {
		var drawingList:Vector.<ARemoteSharedObject>;
		var remote_A:ARemoteSharedObject;
		var i:int;
		var l:int;
		
		drawingList = RemoteManager.getInstance().getDrawingList();
		//l = drawingList.length;
		//while (i < l) {
			//remote_A = drawingList[i++];
			//this.getFusion().insertEventListener(remote_A, ASyncEvent.SYNC, onSync);
		//}
	}
	
	//private function onSync(e:ASyncEvent):void {
		
	//}
	
	private function onTicking(e:TickEvent):void {
		//trace(_actionsList.length);
		
		_currActions = null;
		this.____doCheckAndFlush();
		
		//trace(_actionsList.length);
	}
	
	
	
	private var _paper:CommonPaper;
	
	private var _imageLoader:ImageLoaderUU;
	private var _imageA:ImageUU;
	
	private var _actionsList:Array = []; // 动作列表
	private var _currActions:Array; // 当前帧的记录动作
	
	
	
	private function ____doCheckAndFlush() : void {
		var AY:Array;
		var remote_A:ARemoteSharedObject;
		
		if (_actionsList.length > 0) {
			remote_A = RemoteManager.getInstance().getIdleDrawing();
			if (remote_A) {
				AY = _actionsList.shift();
				remote_A.getData()["A"] = AY;
				remote_A.setDirty("A");
				this.____doCheckAndFlush();
			}
			
			//Agony.getLog().simplify("teacher: " + AY.length / 12);
		}
	}
	
	private function ____doCheckNewActions() : void {
		if (!_currActions) {
			_currActions = [];
			_actionsList.push(_currActions);
		}
		_currActions.push.apply(null, _paper.getSyncData());
		_paper.getSyncData().length = 0;
	}
	
	private function ____onPress(e:ATouchEvent):void {
		_paper.startDraw(e.touch.rootX, e.touch.rootY);
		
		this.____doCheckNewActions();
		
		this.getFusion().insertEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.MOVE,    ____onMove,    100000);
		this.getFusion().insertEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.RELEASE, ____onRelease, 100000);
	}
	
	private function ____onMove(e:ATouchEvent):void {
		if (e.touch.isPressed()) {
			_paper.drawLine(e.touch.rootX, e.touch.rootY, e.touch.prevRootX, e.touch.prevRootY);
			
			this.____doCheckNewActions();
		}
	}
	
	private function ____onRelease(e:ATouchEvent):void {
		this.getFusion().deleteEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.MOVE,    ____onMove);
		this.getFusion().deleteEventListener(this.getRoot().getAdapter().getTouch(), ATouchEvent.RELEASE, ____onRelease);
		
		_paper.endDraw();
	}
	
	private function onKeyDown(e:AKeyboardEvent):void {
		switch(e.keyCode) {
			case Keyboard.NUMBER_1:
				_paper.brushIndex = 0;
				break;
			case Keyboard.NUMBER_2:
				_paper.brushIndex = 1;
				break;
			case Keyboard.NUMBER_3:
				_paper.brushIndex = 2;
				break;
			case Keyboard.NUMBER_4:
				_paper.brushIndex = 3;
				break;
			case Keyboard.NUMBER_5:
				_paper.brushIndex = 4;
				break;
			case Keyboard.NUMBER_6:
				_paper.brushIndex = 5;
				break;
		}
	}
}
}