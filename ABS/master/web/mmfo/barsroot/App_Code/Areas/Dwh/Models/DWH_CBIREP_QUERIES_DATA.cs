namespace BarsWeb.Areas.Dwh.Models
{
    /// <summary>
    /// Summary description for DWH_CBIREP_QUERIES_DATA
    /// </summary>
    public class DWH_CBIREP_QUERIES_DATA
    {
        public decimal ID { get; set; }
        public decimal? CBIREP_QUERIES_ID { get; set; }
        public string RESULT_FILE_NAME { get; set; }
        public decimal? LENGTH_FILE { get; set; }
        public byte[] FIL { get; set; }
    }
}

