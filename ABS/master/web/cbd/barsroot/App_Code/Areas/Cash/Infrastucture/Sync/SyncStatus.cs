
namespace BarsWeb.Areas.Cash.Infrastructure
{
    /// <summary>
    /// Возможные значения статуса синхронизации
    /// </summary>
    public static class SyncStatus
    {
        /// <summary>
        /// Успешно
        /// </summary>
        public static string Success
        {
            get { return "SUCCESS"; }
        }

        /// <summary>
        /// Ошибка
        /// </summary>
        public static string Error
        {
            get { return "ERROR"; }
        }

        /// <summary>
        /// В процессе
        /// </summary>
        public static string InProcess
        {
            get { return "INPROCESS"; }
        }

        /// <summary>
        /// Синхронизация не еще не происходила
        /// </summary>
        public static string NoSync
        {
            get { return "NOSYNC"; }
        }
    }
}