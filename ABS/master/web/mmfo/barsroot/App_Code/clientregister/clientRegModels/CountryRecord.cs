using System;
namespace clientregister
{
	/// <summary>
	/// Запись таблицы Country
	/// </summary>
	public class CountryRecord
	{
		public Decimal COUNTRY;
		public String NAME;
		public CountryRecord()
		{
		}
		public CountryRecord(Decimal COUNTRY, String NAME)
		{
			this.COUNTRY = COUNTRY;
			this.NAME = NAME;
		}
	}
}