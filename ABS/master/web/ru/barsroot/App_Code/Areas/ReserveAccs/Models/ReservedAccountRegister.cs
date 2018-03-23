using BarsWeb.Areas.ReserveAccs.Models.Bases;

namespace BarsWeb.Areas.ReserveAccs.Models
{
    public class ReservedAccountRegister: ReservedAccountBase
    {
        public string Type { get; set; }
        public decimal? Group { get; set; }
        //хз що за параметр
        public decimal? Pap { get; set; }
        public decimal? Subspecies { get; set; }
        public decimal? Pos { get; set; }
        public decimal? DebitBlockCode { get; set; }
        public decimal? CreditBlockCode { get; set; }
        public decimal? Limit { get; set; }
        public decimal? MaxBalance { get; set; }
        public string AlternativeNumber { get; set; }
        public string Branch { get; set; }
        public decimal? UserId { get; set; }
        public string Ob22 { get; set; }
        public decimal? Tarriff { get; set; }
        public string ND { get; set; }
		public int DdVid { get; set; }
		public string MainCurr { get; set; }
	}
}
