package views.UU.room {
	import org.agony2d.flashApi.ImageLoaderUU;
	import org.agony2d.flashApi.MultiStateUU;
	import org.agony2d.flashApi.StateUU;
	
public class TeacherRoom_StateUU extends MultiStateUU {
	
	override public function onEnter() : void {
		
		
		
		this.combine(TeacherBoard_StateUU);
	}
	
}
}