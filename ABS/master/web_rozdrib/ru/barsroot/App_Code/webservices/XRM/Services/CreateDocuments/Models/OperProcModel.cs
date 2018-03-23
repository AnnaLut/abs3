using System;

namespace Bars.WebServices.XRM.Services.CreateDocuments.Models
{
    public class OperProcRequest
    {
        public int Doctype { get; set; }
        public string RequestData { get; set; }
    }

    public class OperProcResponse
    {
        public string ResultData { get; set; }
    }
}