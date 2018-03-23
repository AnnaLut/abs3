using CorpLight.Users.Models;

namespace BarsWeb.Areas.CorpLight.Models
{
    /// <summary>
    /// Summary description for NbsAccType
    /// </summary>
    public class CreateUserModel: BankingUser
    {
        public decimal? CustId { get; set; }
        public decimal? RelatedCustId { get; set; }
        public decimal? IsExistCust { get; set; }
        public decimal? TypeId { get; set; }
    }
}
