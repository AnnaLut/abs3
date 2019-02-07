namespace BarsWeb.Areas.WebApi.Subvention.Models
{
    public class Response<T> : Response
    {
        public T ResultMessage { get; set; }
    }

    public class Response
    {
        public Response()
        {
            ResultCode = 0;
            ErrorMessage = string.Empty;
        }
        public int ResultCode { get; set; }
        public string ErrorMessage { get; set; }
    }
}
