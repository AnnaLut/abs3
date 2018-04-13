using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Информация о дополнительных фильтрах на таблицу для вычитки данных (используется при проваливании в другие справочники с доп. условиями фильтрации).
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