using System;

namespace Bars.WebServices.OutsideServices
{
    public class BaseModel
    {
        public String SystemId { get; set; }
        public Int32 LoginType { get; set; }
    }

    public class ProxyModel: BaseModel
    {
        public String Language { get; set; }

        public String PointCode { get; set; }

        public String UserLogin { get; set; }

        public String UserPassword { get; set; }

    }
}