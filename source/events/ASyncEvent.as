package events 
{
	import org.agony2d.events.AEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class ASyncEvent extends AEvent
	{
		
		public function ASyncEvent( type:String ) 
		{
			super(type);
		}
		
		public static const SYNC : String = "sync";
		
		public var changeList : Array;
		
		
		
	}

}