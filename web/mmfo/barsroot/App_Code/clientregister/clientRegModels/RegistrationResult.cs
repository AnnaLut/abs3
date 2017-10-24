using System;

namespace clientregister
{
	/// <summary>
	/// Результат регистрации
	/// </summary>
	public class RegistrationResult
	{
		public String RegType; /* Reg, ReReg */
		public String Status = "OK"; /* OK, ERROR */
		public String ErrorMessage = "";
		public Decimal Rnk;
		public String ResultText
		{
			get
			{
				switch (Status)
				{
					case "OK":
						return String.Format("Клієнта РНК={0} успішно {1}", Rnk, (RegType == "REG" ? "зареєстровано" : "збережено"));
					case "TOBECONFIRMED":
						return string.Format(@"Клієнта РНК={0} успішно {1}. Зміни набудуть чинності після піптвердження контролером.",
											 Rnk,
											 (RegType == "REG" ? "зареєстровано" : "збережено"));
					case "ERROR":
						return String.Format("Помилки при {0}: {1}", (RegType == "REG" ? "реєстрації" : "збереженні"), ErrorMessage);
					default:
						return String.Empty;
				}
			}
		}

		public RegistrationResult(String RegType)
		{
			this.RegType = RegType;
		}
		public RegistrationResult()
		{
		}
	}
}