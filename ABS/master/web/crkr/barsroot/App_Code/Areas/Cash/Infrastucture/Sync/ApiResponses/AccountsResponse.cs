using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Ответ от метода получения перечня счетов
    /// </summary>
    public class AccountsResponse
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
        /// Текущая банковская дата
        /// </summary>
        public DateTime? BankDate { get; set; }
        
        /// <summary>
        /// Перечень счетов
        /// </summary>
        public IEnumerable<RegionAccount> Accounts { get; set; }
    }
}