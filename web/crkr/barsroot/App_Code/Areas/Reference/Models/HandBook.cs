using System.Collections.Generic;

namespace BarsWeb.Areas.Reference.Models
{
    public class HandBook
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Semantic { get; set; }
        public bool IsRelation { get; set; }
        public bool IsDeleted { get; set; }
        public IEnumerable<HandBookColumn> Columns { get; set; }
    }
}
