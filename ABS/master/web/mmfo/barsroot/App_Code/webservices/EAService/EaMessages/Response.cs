using Newtonsoft.Json;
using System;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Ответ ЕА
    /// </summary>
    public class Response
    {
        [JsonIgnore]
        public String Method;
        [JsonProperty("status")]
        public String Status;
        [JsonProperty("RESULT")]
        public Object Result;
        [JsonProperty("current_timestamp")]
        public DateTime Current_Timestamp;
        [JsonProperty("message_id")]
        public String Message_ID;
        [JsonProperty("responce_id")]
        public String Responce_ID;
        [JsonProperty("error")]
        public Structs.Result.ErrorOnCrash error;

        public Response()
        {
        }

        public static Response CreateFromJSONString(String Method, String JSONString)
        {
            JsonSerializerSettings settings = new JsonSerializerSettings();
            Response res = Newtonsoft.Json.JsonConvert.DeserializeObject<Response>(JSONString, settings);
            res.Method = Method;

            return res;
        }
    }
}