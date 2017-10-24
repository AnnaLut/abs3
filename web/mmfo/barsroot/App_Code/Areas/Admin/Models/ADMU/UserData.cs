
using System;

namespace BarsWeb.Areas.Admin.Models.ADMU
{
    /// <summary>
    /// Модель даних користувача, що редагується
    /// </summary>
    public class UserData
    {
        public string LoginName { get; set; }
        public string UserName { get; set; }
        public string BranchCode { get; set; }
        public string BranchName { get; set; }

        public bool CanSelectBranch { get; set; }
        public bool ExtendetAccess { get; set; }
        public string SecurityTokenPass { get; set; }

        public string UserStateCode { get; set; }
        public string UserStateName { get; set; }

        public bool IsNativeAuth { get; set; }
        public bool IsOracleAuth { get; set; }
        public bool IsAdAuth { get; set; }
        public string AdName { get; set; }

        public string DelegatedUserLogin { get; set; }
        public string DelegatedUserName { get; set; }
        public DateTime? DelegatedFrom { get; set; }
        public DateTime? DelegatedThrough { get; set; }
        public string DelegationComment { get; set; }
        //public string AuthenticationModeCode { get; set; }
        //public string AuthenticationModeName { get; set; }
        //public DateTime? PasswordExpiresAt { get; set; }
        public string[] UserOraRoles { get; set; }
        public string AdmComments { get; set; }
        //public string[] AdditionalBranches { get; set; }
    }
}

