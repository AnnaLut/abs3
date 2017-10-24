using System;

namespace BarsWeb.Core.Models
{
    public class UserInfo
    {
        public decimal? Id { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string AdminPassword { get; set; }
        public string ChangeDate { get; set; }
        public DateTime BankDate { get; set; }
        public string LogLevel { get; set; }
        public decimal? ErrorMode { get; set; }
        public decimal? Blocked { get; set; }
        public string Comment { get; set; }
        public decimal? Attempts { get; set; }
    }
}