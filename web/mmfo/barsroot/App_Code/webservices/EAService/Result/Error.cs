using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Result
{
    /// <summary>
    /// Ответ - Ошибка
    /// </summary>
    public class Error
    {
        [JsonProperty("error_code")]
        public String ErrorCode;
        [JsonProperty("error_text")]
        public String ErrorText;
        [JsonProperty("error")]
        public String ErrorText2;

        public Error() { }
    }

    /// <summary>
    /// Ответ - Ошибка при EA crash
    /// </summary>
    public class ErrorOnCrash
    {
        [JsonProperty("code")]
        public String Code;
        [JsonProperty("message")]
        public String Message;

        public ErrorOnCrash() { }
    }
}