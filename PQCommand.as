package core.pqframe
{
	public class PQCommand implements ICommand
	{
		private var _contact:Function;
		public function PQCommand()
		{
		}
		
		public function execute(param:Object=null, type:String=null):void
		{
		}

		public function get contact():Function
		{
			return _contact;
		}

		public function set contact(value:Function):void
		{
			_contact = value;
		}

	}
}