
using System;

namespace BarsWeb.Areas.Admin.Models.ADMU
{
    public class MainFilters
    {
        public decimal? Id { get; set; }
        public string UserLogin { get; set; }
        public string UserName { get; set; }
        public string UserBranch { get; set; }
        public byte? UserState { get; set; }

        public bool IsEmpty()
        {
            return null == Id
                && string.IsNullOrWhiteSpace(UserLogin)
                && string.IsNullOrWhiteSpace(UserName)
                && string.IsNullOrWhiteSpace(UserBranch)
                && null == UserState;
        }
    }
}

