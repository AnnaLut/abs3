using System.Linq;
using Areas.Arcs.Models;

namespace BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Abstract
{
    public interface IArchivesRepository
    {
        /// <summary>
        /// стан таблиць
        /// </summary>
        /// <returns></returns>
        IQueryable<ARCS_META> GetTableState();
        /// <summary>
        /// детальна інформація по таблиці
        /// </summary>
        /// <param name="tableName">ім"я таблиці</param>
        /// <returns></returns>
        IQueryable<V_ARCS_TAB_REP> GetDeatilOnTable(string tableName);
        /// <summary>
        /// Архивирование секциий таблицы за год
        /// </summary>
        /// <param name="table">Имя таблицы</param>
        /// <param name="year">Год</param>
        /// <param name="rebuildIndex">признак перестроения индексов</param>
        /// <returns></returns>
        int RemoveYear(string table, int year, bool rebuildIndex);
        /// <summary>
        /// Восстановление заархивированных сенкций года
        /// </summary>
        /// <param name="table">Имя таблицы</param>
        /// <param name="year">Год</param>
        /// <param name="rebuildIndex">признак перестроения индексов</param>
        /// <returns></returns>
        int RestoreYear(string table, int year, bool rebuildIndex);
        /// <summary>
        /// Перевод таб.пространства офлайн
        /// </summary>
        /// <param name="table">Имя таблицы</param>
        /// <param name="year">Год</param>
        /// <returns></returns>
        int TakeArcdataOffline(string table, int year);
    }
}
