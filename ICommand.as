package core.pqframe
{
	public interface ICommand
	{
		function set contact(value:Function):void;
		function execute(param:Object=null,type:String=null):void;
	}
}