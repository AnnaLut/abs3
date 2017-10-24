namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// модель FLAGS, Флаги транзакций(операций). tbls: tts_flags,flags
    /// </summary>
    public class TTS_FLAGS
    {
        public decimal CODE { get; set; }
        public string NAME { get; set; }
        public decimal? EDIT { get; set; }
        public decimal? OPT { get; set; }
    }
}

