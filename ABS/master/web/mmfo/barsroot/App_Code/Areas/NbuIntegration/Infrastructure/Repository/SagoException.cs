namespace BarsWeb.Areas.NbuIntegration
{
    public class SagoException : System.Exception
    {
        public int Code { get; set; }
        public string RequestData { get; set; }
        public SagoException(string msg, RequestState code, string requestData) : base(msg)
        {
            this.Code = (int)code;
            this.RequestData = requestData;
        }
    }
}