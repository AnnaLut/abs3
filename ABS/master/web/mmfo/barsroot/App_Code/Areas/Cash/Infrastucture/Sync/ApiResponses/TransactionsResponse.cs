﻿using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Ответ от метода получения Транзакцій
    /// </summary>
    public class TransactionsResponse
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
        /// Перечень Транзакцій
        /// </summary>
        public IEnumerable<RegionTransaction> Transactions { get; set; }
    }
}