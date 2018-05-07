using BarsWeb.Areas.Security.Models.Enums;

namespace BarsWeb.Areas.Security.Models
{
    public class AuthorizedStatus
    {
        public AuthorizedStatusCode Status { get; set; }
        public string Message { get; set; }
    }
}