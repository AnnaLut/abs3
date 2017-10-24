using System;
namespace clientregister
{
	// <summary>
	/// Запись таблицы Codecagent
	/// </summary>
	public class CodecagentRecord
	{
		public Decimal CODCAGENT;
		public Decimal REZID;
		public String NAME;
		public CodecagentRecord()
		{
		}
		public CodecagentRecord(Decimal CODCAGENT, Decimal REZID, String NAME)
		{
			this.CODCAGENT = CODCAGENT;
			this.REZID = REZID;
			this.NAME = NAME;
		}
	}
}