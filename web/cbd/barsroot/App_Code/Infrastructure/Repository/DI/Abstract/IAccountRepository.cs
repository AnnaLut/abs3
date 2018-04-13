using System;
using System.Collections.Generic;
using BarsWeb.Models;

namespace BarsWeb.Infrastructure.Repository.DI.Abstract
{
    public interface IAccountRepository
    {
        /// <summary>
        /// авторизація по логіну і паролю
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        AuthorizedStatus Authorize(string userName, string password);
        /// <summary>
        /// авторизація по логіну і хешу пароля
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="hashPass"></param>
        /// <returns></returns>
        AuthorizedStatus AuthorizeByHash(string userName, string hashPass);
        /// <summary>
        /// Авторизація користувача по логіну
        /// </summary>
        /// <param name="userName">Логін</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode LoginUser(string userName);
        /// <summary>
        /// Авторизація користувача по Ідентифікотору
        /// </summary>
        /// <param name="userId">Ідентифікатор</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode LoginUser(decimal userId);
        /// <summary>
        /// Авторизація користувача в базі
        /// </summary>
        /// <param name="userId">Ідентифікатор</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode BaseLoginUser(decimal userId);       
        /// <summary>
        /// Список відкритих банківських днів
        /// </summary>
        /// <param name="currentMonth">поточний місяць</param>
        /// <returns></returns>
        List<DateTime> GetOpenBankDates(DateTime currentMonth);
        /// <summary>
        /// Змінити банківську дату для користувача 
        /// </summary>
        /// <param name="date">Вибрана дата</param>
        void ChangeUserBankDate(DateTime date);       
        /// <summary>
        /// Журнал подій користувача
        /// </summary>
        /// <param name="pageNum">Номер сторінки</param>
        /// <param name="pageSize">Кількість записів</param>
        /// <returns></returns>
        List<V_SEC_AUDIT_UI> GetUserSecAudit(decimal pageNum, decimal pageSize);
        /// <summary>
        /// Кількість сторінок журналу аудиту користувача
        /// (потрібно для пейжинка по сторінці)
        /// </summary>
        /// <returns></returns>
        decimal GetCountUserSecAudit();
        /// <summary>
        /// Записати помилку в журнал аудиту
        /// </summary>
        /// <param name="stack">Стек помилки</param>
        void SetUserError(string stack);
        /// <summary>
        /// Ім"я WEB-сервера
        /// </summary>
        /// <returns></returns>
        string GetHostName();
        /// <summary>
        /// Очистка темпових дерикторій
        /// </summary>
        void ClearSessionTmpDir();
        /// <summary>
        /// Видалити авторизаційнні данеі користувача
        /// </summary>
        void LogOutUser();
    }


    /// <summary>
    /// Статуси авторизації користувача 
    /// 0 - успішно (дозволено вибір дати)
    /// 1 - помилтка
    /// 2 - успішно
    /// 3 - термін дії пароля минув
    /// </summary>
    public enum AuthorizedStatusCode
    {
        SelectDate, Error, Ok, PasswordExpire
    }
    public class AuthorizedStatus
    {
        public AuthorizedStatusCode Status { get; set; }
        public string Message { get; set; }
    }
}
