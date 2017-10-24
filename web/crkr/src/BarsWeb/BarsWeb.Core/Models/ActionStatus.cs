using BarsWeb.Core.Models.Enums;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace BarsWeb.Core.Models
{
    public class ActionStatus
    {
        public ActionStatus()
        {
            Status = ActionStatusCode.Ok;
            Message = string.Empty;
            Data = null;
        }
        public ActionStatus(ActionStatusCode status)
        {
            Status = status;
            Message = string.Empty;
            Data = null;
        }
        public ActionStatus(ActionStatusCode status, string message)
        {
            Status = status;
            Message = message;
            Data = null;
        }
        public ActionStatus(ActionStatusCode status, string message, object data)
        {
            Status = status;
            Message = message;
            Data = data;
        }
        [JsonConverter(typeof(StringEnumConverter))]
        public ActionStatusCode Status { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
    }
}
