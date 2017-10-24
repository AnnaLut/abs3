namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// Групи контролю / TTS_MonitoringGroup. tbls: chklist_tts,chklist 
    /// </summary>
    public class TTS_MonitoringGroup
    {
        public decimal IDCHK { get; set; }
        public string NAME { get; set; }
        public decimal? F_IN_CHARGE { get; set; }
        public decimal PRIORITY { get; set; }
        public string SQLVAL { get; set; }
        public decimal? FLAGS { get; set; }
    }
}

