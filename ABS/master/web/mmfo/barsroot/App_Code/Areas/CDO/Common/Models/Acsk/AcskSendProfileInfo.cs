using System;

namespace BarsWeb.Areas.CDO.Common.Models.Acsk
{
    public class AcskSendProfileInfo
    {
        public AcskSendProfileInfo()
        {
        }

        public int? RegistrationId { get; set; }
        public string UserId { get; set; }
        public DateTime? RegistrationDate { get; set; }
    }
}