namespace BarsWeb.Areas.Admin.Models.AssignmentSpecParams
{
    public class Parameter : BalanceAccount
    {
        public string Code { get; set; }
        public string ParameterName { get; set; }
        public string RequiredParameter { get; set; }
        public string SqlExpression { get; set; }
        public decimal ParameterId { get; set; }
    }
}