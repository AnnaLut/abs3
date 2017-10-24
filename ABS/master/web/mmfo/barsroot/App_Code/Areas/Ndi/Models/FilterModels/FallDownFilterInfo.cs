using System.Collections.Generic;
using System.Web.Script.Serialization;
using BarsWeb.Areas.Ndi.Models;

namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Информация о дополнительных фильтрах для работы приложения с внешними клиентами
    /// Приходит с клиента
    /// </summary>
    public class FallDownFilterInfo
    {
        /// <summary>
        /// META_FILTERCODES.CODE
        /// </summary>
        public string FilterCode { get; set; }
        /// <summary>
        /// Список параметров, которые нужно подставить в выражение фильтра META_FILTERCODES.CONDITION
        /// </summary>
        public List<FieldProperties> FilterParams { get; set; }

        /// <summary>
        /// Выражение фильтра
        /// </summary>
        [ScriptIgnore]
        public string Condition { get; set; }
    }
}