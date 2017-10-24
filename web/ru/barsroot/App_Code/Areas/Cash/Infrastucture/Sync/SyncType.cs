
namespace BarsWeb.Areas.Cash.Infrastructure
{
    /// <summary>
    /// Типы синхронизации
    /// </summary>
    public static class SyncType
    {
        /// <summary>
        /// Счета
        /// </summary>
        public static string Accounts
        {
            get { return "ACC"; }
        }

        /// <summary>
        /// Остатки по счетам
        /// </summary>
        public static string AccountsRest
        {
            get { return "ACC_ARC"; }
        }

        /// <summary>
        /// Отделения (бранчи)
        /// </summary>
        public static string Branches
        {
            get { return "BRANCH"; }
        }
        /// <summary>
        /// Отделения (бранчи)
        /// </summary>
        public static string Transactions
        {
            get { return "TRANSACTIONS"; }
        }
    }
}