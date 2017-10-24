using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Ответ от метода получения перечня остатков по счетам
    /// </summary>
    public class AccountsRestResponse
    {
        /// <summary>
        /// Успешность выполнения метода
        /// </summary>
        public bool Success { get; set; }

        /// <summary>
        /// Сообщение об ошибке
        /// </summary>
        public string ErrorMessage { get; set; }
        
        /// <summary>
        /// Перечень остатков по счетам
        /// </summary>
        public IEnumerable<RegionAccountRest> AccountsRests { get; set; }
    }
}