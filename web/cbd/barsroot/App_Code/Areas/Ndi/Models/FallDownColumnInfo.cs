using System.Collections.Generic;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Информация о проваливании для колонки (передается на клиент для формирования ссылки на проваливаемый справочник)
    /// </summary>
    public class FallDownColumnInfo
    {
        /// <summary>
        /// ID таблицы, в которую проваливаемся
        /// </summary>
        public int TableId { get; set; }

        /// <summary>
        /// Код фильтра (META_FILTERCODES.CODE)
        /// </summary>
        public string FilterCode { get; set; }

        /// <summary>
        /// Список имен колонок таблицы, которые фигурируют в условии фильтра (значения этих колонок нужно передать на сервер при "проваливании")
        /// </summary>
        public List<string> Columns { get; set; }
    }
}

