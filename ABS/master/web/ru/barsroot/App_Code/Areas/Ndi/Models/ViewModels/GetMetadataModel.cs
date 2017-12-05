namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    /// <summary>
    /// Summary description for GetMetadataModel
    /// </summary>
    public class GetMetadataModel
    {
        public int TableId { get; set; }
        public int? CodeOper  { get; set; }
        public int? SparColumn  { get; set; }
        public int? NativeTabelId  { get; set; }
        public int? NsiTableId { get; set; }
        public int? NsiFuncId { get; set; }
        public string Base64JsonSqlProcParams = "";
        public int? BaseCodeOper { get; set; }
        public string Filtercode { get; set; }

        public string Code { get; set; }

        public string Base64InsertDefParamsString { get; set; }
    }
}