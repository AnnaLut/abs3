namespace BarsWeb.Areas.Reference.Models
{
    public class HandBookColumn
    {
        public int Id { get; set; }
        public int HandBookId { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Semantic { get; set; }
        public int? ShowWidth { get; set; }
        public int? ShowMaxChar { get; set; }
        public int? ShowPosition { get; set; }
        public bool IsShowInRow { get; set; }
        public bool IsShowRetVal { get; set; }
        public bool IsSemantic { get; set; }
        public bool IsExtrnVal { get; set; }
        public string ShowRelCType { get; set; }
        public string ShowFormat { get; set; }
        public bool IsShowInFilter { get; set; }
        public bool IsShowReference { get; set; }
        public string ShowResult { get; set; }
        public short? CaseSensitive { get; set; }
        public bool IsNotToEdit { get; set; }
        public bool IsNotToShow { get; set; }
        public bool IsSimpleFilter { get; set; }
        public string FormName { get; set; }

    }
}
