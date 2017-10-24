using System;
using System.Collections.Generic;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Areas.Security.Models.Enums;

namespace BarsWeb.Areas.Security.Infrastructure.Repository.Abstract
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
}