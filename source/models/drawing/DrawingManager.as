package models.drawing 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.agony2d.flashApi.textures.TextureUU;
	import org.agony2d.flashApi.UUFacade;

public class DrawingManager 
{
	
	public function initialize() : void {
		var eraser:Shape;
		var brush:IBrush;
		var BA:BitmapData;
		var textureUU:TextureUU;
		
		// 绘制图像数据
		BA = new BitmapData(1024, 600, true, 0x0);
		
		paper = new CommonPaper(1024, 600, 1.0, BA);
		paper.isSync(true);
		
		textureUU = new TextureUU(paper.content, false);
		UUFacade.registerAsset("currWhiteBoard", textureUU, "currWhiteBoard");
		
		// 加入画笔
		eraser = new Shape()
		eraser.graphics.beginFill(0x44dd44, 1)
		eraser.graphics.drawCircle(0, 0, ERASER_SIZE)
		eraser.cacheAsBitmap = true	
		
//			var sp:Sprite = new Sprite
//			var bp:Bitmap = new	(ImgAssets.btn_global)
//			var BA:BitmapData = new BitmapData(20 ,20,true,0x0)
//			var MA:Matrix = new Matrix(Config.ERASER_SIZE *2 / bp.width, 0,0,Config.ERASER_SIZE *2/bp.height, 0,0)
//			BA.draw(bp.bitmapData,MA)
//			var eraser:Bitmap = new GameAssets.brush_eraser
//			eraser.bitmapData.colorTransform(eraser.bitmapData.rect, new ColorTransform(0,0,0,1,0,0,0,0))
//			sp.addChild(eraser)
//			bp.x = -bp.width / 2
//			bp.y = -bp.height / 2
		
		
		brush = paper.createTransformationBrush([(UUFacade.getAsset("drawing/brush/waterColor.png", TextureUU) as TextureUU).getBitmapData()], 0, 5,0,0,true);
		
		brush = paper.createTransformationBrush([(UUFacade.getAsset("drawing/brush/pencil.png", TextureUU) as TextureUU).getBitmapData()], 1, 3,0,0,true)
		brush.scale = 0.80;
		
		brush = paper.createTransformationBrush([(UUFacade.getAsset("drawing/brush/crayon.png", TextureUU) as TextureUU).getBitmapData()], 2, 5,0,0,true)
		brush = paper.createCopyPixelsBrush((UUFacade.getAsset("drawing/brush/pink.png", TextureUU) as TextureUU).getBitmapData(), 3, 3)
		brush = paper.createCopyPixelsBrush((UUFacade.getAsset("drawing/brush/maker.png", TextureUU) as TextureUU).getBitmapData(), 4, 5)
		brush.scale = 0.6
		
		brush = paper.createEraseBrush(eraser, 5, 8)
		brush.scale = 1.5;
		
		paper.brushIndex = 0;
	}
	
	
	public static var instance:DrawingManager;
	
	public static function getInstance():DrawingManager {
		return instance ||= new DrawingManager;
	}
	
	// drawing...
	public static const ERASER_SIZE:int = 10
	
	public static const BRUSH_SCALE_MIN:Number = 0.2
	public static const BRUSH_SCALE_MAX:Number = 2
	
	public var paper:CommonPaper;
}

}