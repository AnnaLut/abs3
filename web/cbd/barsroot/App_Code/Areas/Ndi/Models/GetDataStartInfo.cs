namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Описывает набор параметров для выозва метода получения данных справочников
    /// </summary>
    public class GetDataStartInfo
    {
        /// <summary>
        /// ID таблицы
        /// </summary>
        public int TableId { get; set; }
        
        /// <summary>
        /// Название таблицы
        /// </summary>
        public string TableName { get; set; }
        
        /// <summary>
        /// Инфо о сортировке
        /// </summary>
        public SortParam[] Sort { get; set; }

        /// <summary>
        /// Параметры фильтров при фильтрации справочников на заголовках колонок
        /// </summary>
        public GridFilter[] GridFilter { get; set; }

        /// <summary>
        /// Диалоговый фильтр при старте
        /// </summary>
        public FieldProperties[] StartFilter { get; set; }

        /// <summary>
        /// Информация о дополнительных фильтрах для справочника (описываются в META_BROWSETBL и применяются в отдельной форме фильтрации)
        /// </summary>
        public ExtFilter[] ExtFilters { get; set; }

        /// <summary>
        /// Параметры фильтра для проваливания в другие справочники
        /// </summary>
        public FallDownFilterInfo FallDownFilter { get; set; }

        /// <summary>
        /// С какой строки отбирать данные
        /// </summary>
        public int StartRecord { get; set; }
        
        /// <summary>
        /// Количество строк, которые нужно отобрать
        /// </summary>
        public int RecordsCount { get; set; }
        
        /// <summary>
        /// Получить все строки
        /// </summary>
        public bool GetAllRecords { get; set; }
    }
}