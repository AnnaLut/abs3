namespace BarsWeb.Core.Models.Json
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
            Status = status;
            Message = message;
            Data = data;
        }
        public string Status { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
    }

    public static class JsonResponseStatus
    {
        public static string Ok { get { return "OK"; } }
        public static string Error { get { return "ERROR"; } }
    }
}