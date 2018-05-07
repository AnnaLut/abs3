using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Security.Models
{
    public class AuditMessage
    {
        [Key]
        public decimal Id { get; set; }
        public decimal UId { get; set; }
        public string UserName { get; set; }
        public string UserProxy { get; set; }
        public DateTime SystemDate { get; set; }
        public DateTime BankDate { get; set; }
        public string Type { get; set; }
        public string Module { get; set; }
        public string Message { get; set; }
        public string Machine { get; set; }
        public string Object { get; set; }
        public decimal UserId { get; set; }
        public string Branch { get; set; }
        public string Stack { get; set; }
        public string ClientIdentifier { get; set; }
        public string TypeComment { get; set; }
    }
}
