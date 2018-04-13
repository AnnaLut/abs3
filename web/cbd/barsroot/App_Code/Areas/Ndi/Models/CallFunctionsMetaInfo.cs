
namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Информация о процедурах, которые могут быть вызваны из справочников (META_NSIFUNCTION)
    /// </summary>
    public class CallFunctionsMetaInfo
    {
        public decimal? TABID { get; set; }
        public decimal? FUNCID { get; set; }
        public string PROC_NAME { get; set; }
        public string DESCR { get; set; }
        public string PROC_PAR { get; set; }
        public string PROC_EXEC { get; set; }
        public string QST { get; set; }
        public string MSG { get; set; }
        public string CHECK_FUNC { get; set; }
        public object ParamsInfo { get; set; }
    }
}