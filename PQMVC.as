package core.pqframe
{
	import core.evnet.EventMgr;
	
	import flash.utils.Dictionary;

	public class PQMVC
	{
		static public var objListenList:Dictionary=new Dictionary();
		public function PQMVC()
		{
		}
		static public function addListen(name:String,callBack:Function):void{
			EventMgr.Inst.add(name,callBack);
		}
		static public function removeListen(name:String,callBack:Function):void{
			EventMgr.Inst.removeEventListener(name,callBack);
		}
	}
}