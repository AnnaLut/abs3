using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Result
{
    /// <summary>
    /// Ответ - Начало сессии взаимодействия с ЕА
    /// </summary>
    public class StartSession
    {
        [JsonProperty("sessionid")]
        public String SessionID;
    }

    /// <summary>
    /// Ответ - Закрытие сессии взаимодействия с ЕА
    /// </summary>
    public class CloseSession
    {
        [JsonProperty("sessionid")]
        public String SessionID;
    }
}