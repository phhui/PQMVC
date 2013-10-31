package core.pqframe
{	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class PQMediator
	{
		private var NAME:String;
		private var listenList:Object={};
		private var commandList:Object={};
		private var controlList:Object={};
		private var msgList:Object={};
		private var _isShow:Boolean=false;
		private var inited:Boolean=false;
		public function PQMediator(mname:String=null)
		{
			NAME=mname;
			PQMVC.addListen(mname+"_show",show);
			PQMVC.addListen(mname+"_close",close);
		}
		public function init():void{
			
		}
		public function addMsg(name:String,callBack:Function):void{
			if(msgList[name]!=null)throw new Error(name+"重复注册！");
			msgList[name]=callBack;
		}
		public function sendMsg(name:String,param:Object=null):void{
			if(msgList[name]==null)throw new Error(name+"未注册！");
			msgList[name](param);
		}
		/**监听消息**/
		public function addListen(name:String,callBack:Function):void{
			if(listenList[name]!=null)throw new Error(name+"重复监听！");
			listenList[name]=callBack;
			PQMVC.addListen(name,callBack);
		}
		/**移除消息监听**/
		public function removeListen(name:String):void{
			PQMVC.removeListen(name,listenList[name]);
			listenList[name]=null;
		}
		/**注册command**/
		public function addCommand(name:String,commandClass:Class):void{
			if(commandList[name]!=null)throw new Error(name+"已存在！");
			if(commandClass is ICommand)commandList[name]=commandClass;
			else throw new Error("command必需实现ICommand接口");
		}
		/**发送指令到command处理**/
		public function command(name:String,param:Object=null,callBack:Function=null,type:String=null):void{
			if(commandList[name]==null)throw new Error("command指令"+name+"未注册或不存在！");
			var cl:Class=new (commandList[name] as Class)();
			if(callBack!=null)cl.contact=callBack;
			cl["execute"](param,type);
			cl=null;
		}
		public function addControl(name:String,controlClass:Class):void{
			if(controlList[name]!=null)throw new Error(name+"已存在！");
			controlList[name]=new controlClass(this);
		}
		public function control(name:String,param:Object=null,type:String=null):void{
			controlList[name].execute(param,type);
		}
		/**释放**/
		public function destruction():void{
			for(var i:String in listenList){
				PQMVC.removeListen(i,listenList[i]);
				listenList[i]=null;
			}
			listenList=null;
			commandList=null;
		}
		private function show(e:*):void{
			if(!inited)init();
			inited=true;
			showView();
			_isShow=true;
		}
		private function close(e:*):void{
			closeView();
			_isShow=false;
		}
		/**显示界面**/
		public function showView():void{
			throw new Error(NAME+"界面显示没有从show方法实现！");
		}
		/**关闭界面**/
		public function closeView():void{
			throw new Error(NAME+"界面显示没有从close方法实现！");
		}
		public function get isShow():Boolean{
			return _isShow;
		}

	}
}