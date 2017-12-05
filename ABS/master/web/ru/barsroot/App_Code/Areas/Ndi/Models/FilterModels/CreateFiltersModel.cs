using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Summary description for CreateFiltersModel
    /// </summary>
    public class CreateFiltersModel
    {
        public CreateFiltersModel()
        {
            FillFilterTypes();
        }
        public int TableId { get; set; }
        public Dictionary<FilterType, string> FilterTypes { get; set; }
        public List<CreateFilterModel> FiltersList { get; set; }
        private void FillFilterTypes()
        {
            FilterTypes = new Dictionary<FilterType, string>();
            FilterTypes.Add(FilterType.EmptyFilter, "простий фільтр");
            FilterTypes.Add(FilterType.ComplexFilter, "складний фільтр");
        }

    }

    public enum FilterType
    {
        EmptyFilter,
        ComplexFilter
    }
}