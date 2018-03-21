using System;

namespace BarsWeb.Areas.CDO.Common.Models.Acsk
{
    /// <summary>
    /// Summary description for UserProfileRequest
    /// </summary>
    public class AcskRequest
    {
        public AcskRequest()
        {
            Id = Guid.NewGuid().ToString();
            Date = DateTime.Now;
        }
        public string Id { get; set; }
        public DateTime Date { get; set; }
        public decimal Total { get; set; }

        public string Base64RequestData { get; set; }
    }
}