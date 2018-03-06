using System;

namespace BarsWeb.Areas.CDO.Common.Models.Acsk
{
    public class AcskResponse
    {

        public AcskResponse()
        {
            Id = Guid.NewGuid().ToString();
            Date = DateTime.Now;
            Code = "0";
            Message = "Ok";
        }
        public string Id { get; set; }
        public DateTime Date { get; set; }

        public string Code { get; set; }
        public string Message { get; set; }

        public object Data { get; set; }
    }
}