﻿using Bars.CommonModels.ExternUtilsModels;
using Oracle.DataAccess.Client;
using System.Collections.Generic;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Описывает результат выозва метода получения данных справочников
    /// </summary>
    public class GetDataResultInfo
    {
        /// <summary>
        /// Полученный основной набор данных
        /// </summary>
        public IEnumerable<Dictionary<string, object>> DataRecords { get; set; }
        /// <summary>
        /// Общее количесво строк (а не только количество строк, в полученном наборе)
        /// </summary>
        public int RecordsCount { get; set; }
        /// <summary>
        /// признак поздней загрузки. Значит DataRecords создавался с помощью yeld.
        /// И реальный запрос к бд будет при переборе коллекции.
        /// </summary>
        public bool IsLazy { get; set; }
        /// <summary>
        /// Итоговая строка
        /// </summary>
        public Dictionary<string, object> TotalRecord { get; set; }

      
    }
}