
namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// Параметры запуска функции
    /// </summary>
    public class StartOptions
    {
        /// <summary>
        /// Начальное окно
        /// </summary>
        public WindowType StartWindow { get; set; }

        /// <summary>
        /// Название функции
        /// </summary>
        public string FunctionName { get; set; }
    }


    /// <summary>
    /// Тип окна (функции)
    /// </summary>
    public enum WindowType
    {
        /// <summary>
        /// Полный список акцептов
        /// </summary>
        FullAcceptList,
        
        /// <summary>
        /// Полный список транзакций
        /// </summary>
        FullTransactionList
    }
}
