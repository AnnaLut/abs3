using System.Globalization;

namespace clientregister
{
	public static class Common
	{
		private static CultureInfo _cinfo;
		public static CultureInfo cinfo
		{
			get
			{
				if (_cinfo == null) _cinfo = CultureInfo.CreateSpecificCulture("en-GB");
				_cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
				_cinfo.DateTimeFormat.DateSeparator = ".";

				return _cinfo;
			}
		}
	}
}