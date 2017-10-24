namespace BarsWeb.Areas.Admin.Models.ADMU
{
    public class EditUserModel
    {
        public string LoginName { get; set; }
        public string UserName { get; set; }
        public string BranchCode { get; set; }
        public decimal CanSelectBranch { get; set; }
        public decimal ExtendedAccess { get; set; }
        public string SecurityToken { get; set; }
        public decimal UseNativeAuth { get; set; }
        public string CoreBankingPassword { get; set; }
        public decimal UseOracleAuth { get; set; }
        public string OraclePassword { get; set; }
        public string OracleRoles { get; set; }
        public decimal UseAdAuth { get; set; }
        public string ActiveDirectoryName { get; set; }
        public string UserRoles { get; set; }
    }
}