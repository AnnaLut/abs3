
using System.Collections.Generic;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers;
using BarsWeb.Areas.Ndi.Models.ViewModels;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Параметр вызова функции
    /// </summary>
    public class ParamMetaInfo
    {
        public ParamMetaInfo()
            :this(false)
        {

        }
        public ParamMetaInfo(bool isInput)
        {
            AdditionalUse = new List<string>();
            IsInput = isInput;
        }

        public ColumnViewModel ColumnInfo { get; set; }
        /// <summary>
        /// Имя колонки
        /// </summary>
        public string ColName { get; set; }

        /// <summary>
        /// Имя параметра
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// ресурс, откуда берется параметр(из колонки грида, из файла...)
        /// </summary>
        public string GetFrom { get; set; }

        /// <summary>
        /// Тип колонки
        /// </summary>
        public string ColType { get; set; }

        /// <summary>
        /// Вводимый параметр (true - запросить у пользователя ввод перед вызовом функции)
        /// </summary>
        public bool IsInput { get; set; }

        /// <summary>
        /// Описание параметра
        /// </summary>
        public string Kind { get; set; }

        /// <summary>
        /// Значение по умолчанию
        /// </summary>
        public string DefaultValue { get; set; }
      
       public string SelectDefValue { get; set; }
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

        public string SrcTextColName2 { get; set; }

        /// <summary>
        /// Опеределяет какие дополнительныедействия будем делать на фронтенде, 
        /// заменять семантику таблицы (ReplaseTableSemantic)  и др. 
        /// для того, что бы мы брали полученные по из предыдущей табличной формы, или 
        /// из другого источника параметры, и сохраненные на странице(saveInPageParams)
        /// и использовали по назначению
        /// </summary> 
        public List<string> AdditionalUse { get; set; }

        public bool FileForBackend { get; set; }
    }
}
