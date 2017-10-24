namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Summary description for CreateFilterResult
    /// </summary>
    public class CreateFilterResult
    {
        public CreateFilterResult()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string FilterName { get; set; }
        public string WhereClause { get; set; }
        public string FilterTypeDescription { get; set; }
    }
}