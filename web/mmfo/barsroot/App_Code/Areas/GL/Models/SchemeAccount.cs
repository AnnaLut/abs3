namespace BarsWeb.Areas.GL.Models
{

    public class BaseDictionary
    {
        public string Id { get; set; }
        public string Name { get; set; }
    }

    public class BaseBank
    {
        public string BankId { get; set; }
        public string Name { get; set; }
    }

    public class BaseCurrency
    {
        public int CurrId { get; set; }
        public string Name { get; set; }
    }
    public class BaseAccount {
        public decimal? AccId { get; set; }
        public string AccNum { get; set; }
        public int CurrId { get; set; }
        public string Name { get; set; }
    }
    /// <summary>
    /// Summary description for SchemaAccount
    /// </summary>
    /// 
    public class SchemeAccount : BaseAccount
    {
        public decimal? GroupId { get; set; }
        public decimal? SchemaId { get; set; }
        public decimal? CalcMethod { get; set; }
        public string CustCode { get; set; }
    }
}