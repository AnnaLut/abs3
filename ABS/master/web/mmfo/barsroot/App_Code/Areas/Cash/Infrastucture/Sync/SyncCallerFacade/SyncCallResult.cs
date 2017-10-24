
namespace BarsWeb.Areas.Cash.Infrastructure
{
    /// <summary>
    /// Результат вызова метода синхронизации
    /// </summary>
    public class SyncCallResult
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }
}