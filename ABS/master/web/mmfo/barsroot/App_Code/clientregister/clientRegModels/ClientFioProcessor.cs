using System;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Linq;
using System.Text;

namespace clientregister
{
	/// <summary>
	/// Конвертор у родовий відмінок
	/// </summary>
	public class ClientFioProcessor : ClientFio
	{
		private ClientFio data;
		public ClientFioProcessor(ClientFio source)
		{
			this.data = source;
		}
		public string SNGC
		{
			get { return getSN_GC().ToUpper(); }
		}
		#region helperMethods
		private string getItemEnding(string item, int size)
		{
			return item.Substring(item.Length - size);
		}
		private string RemoveLastVowel(string item)
		{
			return (isVowel(item.Last())) ? item.Remove(item.Length - 1) : item;
		}
		private bool isVowel(char item)
		{
			char[] vowels = { 'А', 'O', 'У', 'I', 'И', 'Е', 'Я', 'Ю', 'Є', 'Ї' };
			return vowels.Contains(item);
		}
		private string toLastConsonant(string item)
		{
			while (isVowel(item.Last()))
			{
				item = item.Remove(item.Length - 1);
			}
			return item;
		}
		private string Concat(string[] source, char delimeter)
		{
			var sBufer = new StringBuilder();
			foreach (var item in source)
			{
				sBufer.Append(item);
				sBufer.Append(delimeter);
			}
			return sBufer.ToString();
		}
		#endregion
		#region private methods
		private string getSN_GC()
		{
			return Concat(new string[3]
			{
							   getProcessedSurname(),
							   getProcessedName(),
							   getProcessedMiddleName()
			}, ' ');
		}
		private string CheckBaseData(string fioPart, string source)
		{
			var expectedResult = "";
			using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
			{
				using (OracleCommand cmd = con.CreateCommand())
				{
					var field = fioPart + "UAROD";
					var table = "BARS.V_" + fioPart + "_NAMES";

					var query = @"select {0} 
											from {1} t 
											where (t.{2}UA = '{3}' 
												or t.{2}RU = '{3}') " +
					(this.Sex != null ? @"and sexid = {4}" : "");

					cmd.CommandText = String.Format(query,
													field,
													table,
													fioPart,
													source.Replace("'", "''"),
													data.Sex);

					using (OracleDataReader rdr = cmd.ExecuteReader())
					{
						if (rdr.Read())
						{
							expectedResult = rdr[field].ToString();
						}
					}
				}
			}
			return expectedResult;
		}
		private string getProcessedName()
		{
			if (String.IsNullOrEmpty(data.Name))
				return "";

			var expectedName = CheckBaseData("FIRST", data.Name);
			if (expectedName != "")
			{
				return expectedName;
			}
			else
			{
				var pname = RemoveLastVowel(data.Name);

				//female
				if (data.Sex == "2")
				{
					if (pname.Last() == 'Й')
						return pname.Remove(pname.Length - 1) + 'Ї';
					return pname + 'И';
				}
				// male
				else
				{
					if (pname.Last() == 'Й')
						return pname.Remove(pname.Length - 1) + 'Я';
					return pname + 'А';
				}
			}
		}
		private string getProcessedMiddleName()
		{
			if (String.IsNullOrEmpty(data.MName))
				return "";

			var expectedName = CheckBaseData("MIDDLE", data.MName);
			if (expectedName != "")
			{
				return expectedName;
			}
			else
			{
				var pname = RemoveLastVowel(data.MName);

				//female
				if (data.Sex == "2")
				{
					return (pname.Last() == 'Й') ? (pname + "ЇВНИ") : (pname + "ІВНИ");
				}
				// male
				else
				{
					return pname + "ОВИЧА";
				}
			}
		}
		private string getProcessedSurname()
		{
			if (String.IsNullOrEmpty(data.SName))
				return "";

			var pname = data.SName;

			//female
			if (data.Sex == "2")
			{
				if (!isVowel(pname.Last()) || pname.Last() == 'О')
				{
					return pname;
				}
				return RemoveLastVowel(pname) + "И";
			}
			else
			{
				if (getItemEnding(pname, 2) == "ИЙ") //ого - ього
				{
					return pname.Substring(0, pname.Length - 2) + "ОГО";
				}
				if (getItemEnding(pname, 2) == "ІЙ")
				{
					return pname.Substring(0, pname.Length - 2) + "ЬОГО";
				}
				if (isVowel(pname.Last()))
				{
					if (pname.Last() == 'А')
					{
						return pname.Remove(pname.Length - 1) + "И";
					}
					return pname.Remove(pname.Length - 1) + "А";
				}
				else
				{
					if (pname.Last() == 'Ь' || pname.Last() == 'Й')
					{
						return pname.Remove(pname.Length - 1) + "Я";
					}
					return pname + "А";

				}
			}
		}
		#endregion
	}
}