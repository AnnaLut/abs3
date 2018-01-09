using System.Collections.Generic;

namespace BarsWeb.Areas.Reference.Models
{
    public class WebGrid
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Semantic { get; set; }
        public bool IsRelation { get; set; }
        public Dictionary<string,object> Fields { get; set; }
        public IEnumerable<WebGridColumn> Columns { get; set; }
    }
}
