using System;

namespace BarsWeb.CheckInner
{
	/// <summary>
	/// Роль и представление приложения.
	/// </summary>
	public class AppPars
	{
		public string Role;
		public string Table;

		public AppPars(string type)
		{
			switch (type)
			{
					//-- самовиза 
				case "0" : 
				{
					Role = "WR_CHCKINNR_SELF";
					Table = "V_USER_SELFVISA_DOCS";
				}
					break;
					//-- визирование всех документов
				case "1" : 
				{
					Role = "WR_CHCKINNR_ALL";
					Table = "V_USER_VISA_DOCS";
				}
					break;
					//-- визирование документов отделения
				case "2" : 
				{
					Role = "WR_CHCKINNR_TOBO";
					Table = "V_USER_TOBO_DOCS";
				}
					break;
                    //-- верификация ввода
                case "3":
                    {
                        Role = "WR_VERIFDOC";
                        Table = "V_USER_TOBO_DOCS";
                    }
                    break;
                //-- визирование документов своего и подчиненных отделений
                case "4":
                    {
                        Role = "WR_CHCKINNR_SUBTOBO";
                        Table = "V_USER_SUBTOBO_DOCS";
                    }
                    break;
                //-- визирование кассовых документов
                case "5":
                    {
                        Role = "WR_CHCKINNR_CASH";
                        Table = "V_USER_CASHVISA_DOCS";
                    }
                    break;
                //-- візування сховищних операцій
                case "6":
                    {
                        Role = "WR_CHCKINNR_CASH";
                        Table = "V_USER_CASH2VISA_DOCS";
                    }
                    break;
            }				
		}
	}
}
