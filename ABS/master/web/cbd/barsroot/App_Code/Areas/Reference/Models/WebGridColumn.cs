using System.Collections.Generic;

namespace BarsWeb.Areas.Reference.Models
{
    public class WebGridColumn
    {
        public string field { get; set; }
        public string title { get; set; }
        public string width { get; set; }
        public string template { get; set; }
        public bool filterable { get; set; }
        public bool sortable { get; set; }
        public Dictionary<string, object> attributes { get; set; }
        public string headerTemplate { get; set; }
    }
}
