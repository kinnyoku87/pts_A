package views.UU.room {
	import models.drawing.DrawingManager;
	import org.agony2d.events.AdapterEvent;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.flashApi.core.NodeUU;
	import org.agony2d.flashApi.FusionUU;
	import org.agony2d.flashApi.ImageUU;
	import org.agony2d.flashApi.locating.LocatingType;
	import org.agony2d.flashApi.locating.Location;
	import org.agony2d.flashApi.locating.UULocating;
	import org.agony2d.flashApi.StateUU;
	
public class Brush_StateUU extends StateUU {
	
	override public function onEnter() : void {
		doInitBrushView();
		
		this.onRootResize(null);
		
		this.doSelectBrush(3);
		
		this.getFusion().insertEventListener(this.getRoot().getAdapter(), AdapterEvent.ROOT_RESIZE, onRootResize);
	}
	
	private function onRootResize(e:AdapterEvent):void {
		var location_A:Location;
		
		location_A = UULocating.locate(this.getFusion());
		location_A.vertiType = LocatingType.F____A_F;
	}
	
	private var _currIndex:int = -1;
	private var _brushList:Array;
	private const GAP_Y:Number = -3
	
	private const brushCoord:Array = [91, GAP_Y + 8, 
									167, GAP_Y - 8,
									269, GAP_Y + 3,
									354, GAP_Y + 11, 
									425, GAP_Y + 11, 
									500, GAP_Y + 11];
								
	private function doInitBrushView():void {
		const brushAssetNames:Array = ["crayon", "eraser", "maker", "pencil", "pink", "waterColor"];
		
		
		var brush:ImageUU;
		var i:int;
		var l:int;
		
		this.getFusion().spaceHeight = 100;
		
		_brushList = [];
		l = brushAssetNames.length;
		while (i < l) {
			brush = new ImageUU;
			brush.textureId = "drawing/icon/" + brushAssetNames[i] + ".png";
			this.getFusion().addNode(brush);
			brush.x = brushCoord[i * 2];
			brush.y = brushCoord[i * 2 + 1];
			brush.userData = i;
			_brushList[i++] = brush;
			brush.addEventListener(ATouchEvent.CLICK, onClick);
		}
	}
	
	private function onClick(e:ATouchEvent):void {
		var brushIndex:int;
		
		brushIndex = int((e.target as NodeUU).userData);
		this.doSelectBrush(brushIndex);
		
		//trace(brushIndex);
	}
	
	private function doSelectBrush( index:int ) : void {
		var brush:ImageUU;
		
		if (_currIndex >= 0) {
			brush = _brushList[_currIndex];
			brush.y = brushCoord[_currIndex * 2 + 1];
		}
		_currIndex = index;
		brush = _brushList[_currIndex];
		brush.y = brushCoord[_currIndex * 2 + 1] - 22;
		
		DrawingManager.getInstance().paper.brushIndex = index;
	}
}
}