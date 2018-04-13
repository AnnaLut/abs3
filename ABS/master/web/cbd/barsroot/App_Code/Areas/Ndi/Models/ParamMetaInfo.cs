
namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Параметр вызова функции
    /// </summary>
    public class ParamMetaInfo
    {
        /// <summary>
        /// Имя колонки
        /// </summary>
        public string ColName { get; set; }

        /// <summary>
        /// Тип колонки
        /// </summary>
        public string ColType { get; set; }

        /// <summary>
        /// Вводимый параметр (true - запросить у пользователя ввод перед вызовом функции)
        /// </summary>
        public bool IsInput { get; set; }

        /// <summary>
        /// Значение по умолчанию
        /// </summary>
        public string DefaultValue { get; set; }
      
        /// <summary>
        /// Наименование колонки
        /// </summary>
        public string Semantic { get; set; }

        /// <summary>
        /// Код таблицы для выпадающего списка
        /// </summary>
        public string SrcTableName { get; set; }

        /// <summary>
        /// Имя колонки для выпадающего списка
        /// </summary>
        public string SrcColName { get; set; }

        /// <summary>
        /// Наименование колонки для выпадающего списка
        /// </summary>
        public string SrcTextColName { get; set; }
    }
}
