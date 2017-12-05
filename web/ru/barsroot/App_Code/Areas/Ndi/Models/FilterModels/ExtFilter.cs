using BarsWeb.Areas.Ndi.Models;

namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Параметры дополнительных фильтров справочника (не по колонкам грида, задаются в отдельной форме, описываются в META_BROWSETBL)
    /// </summary>
    public class ExtFilter
    {
        public ExtFilterMeta ExtFilterMeta;
        public string Value;
    }
}