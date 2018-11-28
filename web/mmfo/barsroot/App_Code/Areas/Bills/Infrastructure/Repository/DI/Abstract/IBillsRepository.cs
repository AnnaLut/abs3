using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Репозиторий для получения, изменения, удаления, добавления данных!
    /// </summary>
    public interface IBillsRepository
    {
        
        /// <summary>
        /// Получение документа по его ИД
        /// </summary>
        /// <param name="docId">ИД документа</param>
        /// <returns></returns>
        Byte[] GetPrintDoc(Int32 docId);
        
        /// <summary>
        /// Обработка запроса для Kengo grid с передаваемыми параметрами
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="request">Объект для фильтрации данных Kendo</param>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        DataSourceResult GetKendoData<T>(DataSourceRequest request, BillsSql sql);

        /// <summary>
        /// Обработка запроса для Kengo grid с передаваемой строкой запроса
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="request">Объект для фильтрации данных Kendo</param>
        /// <param name="sql">Строка запроса</param>
        /// <returns></returns>
        DataSourceResult GetKendoData<T>(DataSourceRequest request, String sql);

        /// <summary>
        /// Обработка запроса с возвращаемой строкой как результат обработки
        /// </summary>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        String ExecuteRequestAndGetTextResponse(BillsSql sql);

        /// <summary>
        /// Получение первого елемента по результату поика
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        T GetElement<T>(BillsSql sql);

        /// <summary>
        /// Получение елементов по результату поиска с параметрами
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        List<T> GetElements<T>(BillsSql sql);

        /// <summary>
        /// Получение елементов по результату поиска по строке поиска
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Строка поиска</param>
        /// <returns></returns>
        List<T> GetElements<T>(String sql);

        /// <summary>
        /// Получение количексва елементов по результату поиска
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        Int32 GetCount<T>(BillsSql sql);

        /// <summary>
        /// получение елементов и отбор среди них необходимых с помощью предиката
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        List<T> GetElements<T>(String sql, Func<T, Boolean> predicate);

        /// <summary>
        /// Обработка процедур с открытым соединением
        /// </summary>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <param name="toClose">true - закрыть соединение</param>
        /// <param name="userName">Login текущего пользователя</param>
        /// <returns></returns>
        OracleParameterCollection ExecuteProcedureAndKeepOpen(BillsSql sql, Boolean toClose, String userName);

        /// <summary>
        /// Откат транзакции (в случае ошибки или...)
        /// </summary>
        void RollbackTransaction(String userName);

        /// <summary>
        /// Проверка - нужна ли подпись при сохранении
        /// </summary>
        /// <returns></returns>
        Int32 GetStatusToSign(BillsSql sql);

        /// <summary>
        /// Формирование проводки
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        String Entry(BillsSql sql);

        /// <summary>
        /// Загрузка файла реструктуризированной задолжеости с ДКСУ 
        /// и получение его ИД в АБС
        /// </summary>
        /// <returns></returns>
        AmountOfRestructuredDeptDowloadResult DownloadAmountOfRestructuredDept(BillsSql sql);

        ///// <summary>
        ///// Получение массива байт из таблицы bills.documents по ИД
        ///// </summary>
        ///// <param name=""></param>
        ///// <returns></returns>
        //Byte[] GetFile(BillsSql sql);

        List<T> GetTransformedKendoData<T>(Kendo.Mvc.UI.DataSourceRequest request, BillsSql sql);

        /// <summary>
        /// Получение текущего МФО
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        String GetCurrentUserMfo(String sql);

        /// <summary>
        /// Обработка процедуры и возвращение параметра (output) типа int по его имени
        /// </summary>
        /// <param name="sql">строка запроса и передаваемые параметры</param>
        /// <param name="paramName">имя возвращаемого параметра</param>
        /// <returns></returns>
        Int32 ExecuteAndGetInputOutputId(BillsSql sql, String paramName);

        /// <summary>
        /// Выполнение процедуры без возвращаемых параметров
        /// </summary>
        /// <param name="sql">строка запроса и передаваемые параметры</param>
        void ExecuteProcedure(BillsSql sql);
    }
}