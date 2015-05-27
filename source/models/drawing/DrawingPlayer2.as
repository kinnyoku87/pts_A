package models.drawing {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import models.drawing.supportClasses.BrushBase;
	import models.drawing.supportClasses.PaperBase;
	
	import org.agony2d.base.inside.agony_internal;
	use namespace agony_internal;
	
public class DrawingPlayer2 extends PaperBase {
	
	public function DrawingPlayer2( paper:CommonPaper ) {
		super(paper.contentRatio)
		
		m_content = paper.m_content
		m_content.fillRect(m_content.rect, 0x0)
		m_base = paper.m_base ? paper.m_base.clone() : null
		m_brushList = paper.m_brushList
	}
	
	private var _syncData:Array;
	private var _currIndex:int;
	
	
	
	public function drawData( syncData:Array ) : void {
		if (!syncData) {
			return;
		}
		_syncData = syncData;
		this.doNextDraw();
	}
	
	protected function doNextDraw() : void{
		if (_currIndex < _syncData.length) {
			this.doPlayNext(_currIndex);
		}
		else {
			_currIndex = 0;
		}
	}
	
	protected function doPlayNext( index:int ):void{
		var currX:Number, currY:Number, prevX:Number, prevY:Number, density:Number, scale:Number, alpha:Number, completeTime:Number
		var brushIndex:int, type:int, brushType:int
		var color:uint, position:uint
		var BA:ByteArray = m_bytesB
		var beginningTime:int, currTime:int
		var finished:Boolean
		
		type = _syncData[index];
		brushIndex = _syncData[index + 1];
		brushType = _syncData[index + 2];
		density = _syncData[index + 3];
		scale = _syncData[index + 4];
		if(brushType > 1){
			color = _syncData[index + 5]
			alpha = _syncData[index + 6]
			if(brushType == 3){
				cachedAngle = _syncData[index + 7]
			}
		}
		if(type == 0){
			currX = _syncData[index + 8] * .1 * m_contentRatio
			currY = _syncData[index + 9] * .1 * m_contentRatio
		}
		else if(type == 1){
			currX = _syncData[index + 8] * .1 * m_contentRatio
			currY = _syncData[index + 9] * .1 * m_contentRatio
			prevX = _syncData[index + 10] * .1 * m_contentRatio
			prevY = _syncData[index + 11] * .1 * m_contentRatio
		}
		if(type == 0){
			this.doDrawPoint(m_brushList[brushIndex], currX, currY, density, scale, color, alpha)
		}
		else if(type == 1){
			this.doDrawLine(m_brushList[brushIndex], currX, currY, prevX, prevY, density, scale, color, alpha)
		}
		_currIndex += 12;
		this.doNextDraw();
	}
	
	protected function doDrawPoint( brush:BrushBase, currX:Number, currY:Number, density:Number, scale:Number, color:uint, alpha:Number ):void{
		brush.m_density = density
		brush.m_scale = scale
		brush.m_color = color
		brush.m_alpha = alpha
		brush.drawPoint(currX, currY)
	}
	
	protected function doDrawLine( brush:BrushBase, currX:Number, currY:Number, prevX:Number, prevY:Number, density:Number, scale:Number, color:uint, alpha:Number ):void{
		brush.m_density = density
		brush.m_scale = scale
		brush.m_color = color
		brush.m_alpha = alpha
		brush.drawLine(currX, currY, prevX, prevY)
	}
	
}
}