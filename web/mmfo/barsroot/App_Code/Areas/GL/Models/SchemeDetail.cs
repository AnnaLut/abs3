namespace BarsWeb.Areas.GL.Models
{
    /// <summary>
    /// Summary description for SchemeGroup
    /// </summary>
    public class SchemeDetail
    {

        // id, idr as Level,  vob as OpType, tt as OpCode, kv as CurrId, koef as Coefficient, mfob as RecipientBankId, nlsb as RecipientAccNum,  polu as RecipientName, nazn, okpo as RecipienCustCode
        public decimal? Id { get; set; }
        public decimal? SchemaId { get; set; }
        public decimal? Scale { get; set; }
        public decimal? OpType { get; set; }
        public string OpCode { get; set; }
        public int? CurrId { get; set; }
        public decimal? Coefficient { get; set; }
        public string RecipientBankId { get; set; }
        public string RecipientAccNum { get; set; }
        public string RecipientName { get; set; }
        public string RecipienCustCode { get; set; }
        public string Narrative { get; set; }

        public int? Kod { get; set; }
        public string Formula { get; set; }
    }
}