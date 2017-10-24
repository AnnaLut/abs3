using System;
namespace clientregister
{
	/// <summary>
	/// Контейнер для параметров валидации клиента
	/// </summary>
	public class CustomerParameters
	{
		/// <summary>
		/// признак чи використовується валідація в ЄБК
		/// </summary>
		public bool UseCdmValidation { get; set; }
		/// <summary>
		/// Признак чи потрібно підтверджувати мобільний телефон
		/// </summary>
		public bool CellPhoneConfirmation { get; set; }
	}
}