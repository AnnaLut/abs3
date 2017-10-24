using System;

namespace BarsWeb.Core.Logger
{
    public interface IDbLogger
    {
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Trace(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Trace(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Debug(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Debug(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Info(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Info(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Security(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Security(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Financial(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Financial(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Warning(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Warning(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Error(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Error(string messageText, string moduleName);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        decimal Fatal(string messageText);

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        decimal Fatal(string messageText, string moduleName);
        /// <summary>
        /// Запис в базу інформації
        /// про помилку
        /// </summary>
        /// <param name="e">Помилка</param>
        /// <returns>Номер запису в базі</returns>
        decimal Exception(Exception e);

    }
}