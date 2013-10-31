package core.pqframe
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import utils.AlignAuto;

	public class PQUIController implements IControl
	{
		private var md:PQMediator;
		public function PQUIController(m:PQMediator)
		{
			md=m;
		}
		/**给指定对象添加监听事件**/
		public function addListen(obj:DisplayObject,type:String,callBack:Function):void{
			if(PQMVC.objListenList[{obj:obj,type:type}]!=null)return;
			PQMVC.objListenList[{obj:obj,type:type}]={obj:obj,type:type,callBack:callBack};
			if(PQMVC.objListenList[obj]==null)PQMVC.objListenList[obj]={};
			PQMVC.objListenList[obj][type]=callBack;
			obj.addEventListener(type,callBack);
			obj.addEventListener(Event.REMOVED_FROM_STAGE,removeObjListen);
		}
		/**移除指定对象某个事件监听**/
		public function removeListen(obj:DisplayObject,type:String,callBack:Function):void{
			delete PQMVC.objListenList[{obj:obj,type:type}];
			PQMVC.objListenList[obj][type]=null;
			obj.removeEventListener(type,callBack);
		}
		/**移除单个对象所有监听**/
		private function removeObjListen(e:Event):void
		{
			for(var i:String in PQMVC.objListenList[e.target]){
				e.target.removeEventListener(i,PQMVC.objListenList[e.target][i]);
				delete PQMVC.objListenList[{obj:e.target,type:i}];
			}
			e.target.removeEventListener(Event.REMOVED_FROM_STAGE,removeObjListen);
			PQMVC.objListenList[e.target]=null;			
		}
		/**发送指令到command处理**/
		public function command(name:String,param:Object=null,callBack:Function=null,type:String=null):void{
			md.command(name,param,callBack,type);
		}
		public function sendMsg(name:String,data:Object=null):void{
			md.sendMsg(name,data);
		}
		public function align(obj:DisplayObject,alignH:Number=0,alignV:Number=0,x:int=0,y:int=0):void{
			AlignAuto.addDisplay(obj,alignH,alignV,x,y);
		}
		/**释放**/
		public function destruction():void{
			for(var i:Object in PQMVC.objListenList){
				if(i is DisplayObject){
					for(var j:String in PQMVC.objListenList[i]){
						removeListen(i as DisplayObject,j,PQMVC.objListenList[i][j]);
					}
				}
				delete PQMVC.objListenList[i];
			}
			PQMVC.objListenList=new Dictionary();
			md=null;
		}

		public function execute(param:Object=null, type:String=null):void
		{
			// TODO Auto-generated method stub
		}
	}
}