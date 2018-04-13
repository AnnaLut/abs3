using Newtonsoft.Json;

namespace BarsWeb.Areas.LimitControl.ViewModels
{
    /// <summary>
    /// Ответ от операции подтверждения переводов
    /// </summary>
    public class ConformationResponse
    {
        /// <summary>
        /// Признак успешности
        /// </summary>
        [JsonProperty("success")]
        public bool Success { get; set; }

        /// <summary>
        /// Сообщение
        /// </summary>
        [JsonProperty("message")]
        public string Message { get; set; }

        /// <summary>
        /// Сообщение об ошибке
        /// </summary>
        [JsonProperty("errorMessage")]
        public string ErrorMessage { get; set; }
    }
}

//для сумісності з дельта 85
namespace Areas.LimitControl.ViewModels
{
    public class ConformationResponse : BarsWeb.Areas.LimitControl.ViewModels.ConformationResponse
    {
    }
}