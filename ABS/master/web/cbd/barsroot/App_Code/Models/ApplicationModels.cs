namespace BarsWeb.Models
{
    public class JsonResponse
    {
        public JsonResponse(): this(JsonResponseStatus.Ok)
        {
        }
        public JsonResponse(string status): this(status, null)
        {
        }
        public JsonResponse(string status, string message): this(status, message, null)
        {
        }
        public JsonResponse(string status, string message, object data)
        {
            this.status = status;
            this.message = message;
            this.data = data;
        }
        public string status { get; set; }
        public string message { get; set; }
        public object data { get; set; }
    }

    public static class JsonResponseStatus
    {
        public static string Ok { get { return "ok"; } }
        public static string Error { get { return "error"; } }
    }
}