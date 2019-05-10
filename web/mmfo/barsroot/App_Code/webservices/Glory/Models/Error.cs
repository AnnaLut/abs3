using System;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Модель для сериализации в xml с описанием ошибок
    /// </summary>
    [Serializable]
    public class Error
    {
        public string Message { get; set; }
        public string StackTrace { get; set; }

        public Error() { }

        public Error(System.Exception ex)
        {
            this.Message = ex.Message;
            this.StackTrace = ex.StackTrace;
        }

        public Error(String message, String stackTrace)
        {
            this.Message = message;
            this.StackTrace = stackTrace;
        }
    }
}