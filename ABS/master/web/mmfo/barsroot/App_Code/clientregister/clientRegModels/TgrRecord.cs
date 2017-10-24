using System;
namespace clientregister
{
	/// <summary>
	/// Запись таблицы Tgr
	/// </summary>
	public class TgrRecord
	{
		public Decimal TGR;
		public String NAME;
		public TgrRecord()
		{
		}
		public TgrRecord(Decimal TGR, String NAME)
		{
			this.TGR = TGR;
			this.NAME = NAME;
		}
	}
}