namespace BarsWeb.Areas.Admin.Models.Oper
{
    /// <summary>
    /// модель "Види документів", tbls: tts_vob, vob
    /// </summary>
    public class TTS_VOB
    {
        public decimal VOB { get; set; }
        public string NAME { get; set; }
        public string REP_PREFIX { get; set; }
        public decimal? ORD { get; set; }
    }
}
