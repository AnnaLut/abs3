using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Ответ от метода получения перечня банковских дат
    /// </summary>
    public class BankDatesResponse
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
        /// Перечень банковских дат
        /// </summary>
        public IEnumerable<DateTime> BankDates { get; set; }
    }
}