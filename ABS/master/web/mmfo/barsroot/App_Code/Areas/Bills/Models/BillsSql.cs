using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель хранения данных для запроса к БД!
    /// </summary>
    public class BillsSql
    {
        /// <summary>
        /// Текст запроса
        /// </summary>
        public String SqlText { get; set; }

        /// <summary>
        /// Параметры запроса
        /// </summary>
        public List<OracleParameter> Parameters { get; set; }
    }
}