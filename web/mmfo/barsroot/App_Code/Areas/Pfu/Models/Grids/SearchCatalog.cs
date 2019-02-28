using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class SearchCatalog
    {
        public DateTime? CatalogDate { get; set; }
        public DateTime? PayDate { get; set; }
        public decimal? IdCatalog { get; set; }
        public string Mfo { get; set; }
        public decimal? EnvelopeId { get; set; }
        public string State { get; set; }
        public string FileType { get; set; }
    }
}