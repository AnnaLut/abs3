using System;
using System.Collections.Generic;
using System.IO;
using BarsWeb.Areas.Ndi.Models;

namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract
{
    public interface IReferenceBookRepository
    {
        /// <summary>
        /// Выполнить экспорт данных в Excel
        /// </summary>
        /// <param name="tableId"></param>
        /// <param name="tableName"></param>
        /// <param name="sort"></param>
        /// <param name="gridFilter"></param>
        /// <param name="externalFilter"></param>
        /// <param name="fallDownFilter"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="getAllRecords">Экспорт всех строк. Если указано, то игнорируются параметры <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        MemoryStream ExportToExcel(int tableId, string tableName, SortParam[] sort, GridFilter[] gridFilter, ExtFilter[] externalFilter, FallDownFilterInfo fallDownFilter, int start = 0, int limit = 10, bool getAllRecords = false);

        /// <summary>
        /// Обновить данные справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="updatableRowKeys">Значениями ключевых полей по которым выполнять update (используется оптимистическая блокировка)</param>
        /// <param name="updatableRowData">Новые значения полей, которые были изменены</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool UpdateData(int tableId, string tableName, List<FieldProperties> updatableRowKeys, List<FieldProperties> updatableRowData);

        /// <summary>
        /// Вставить данные в справочник
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="insertableRow">Данные для вставки для вставки</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow);

        /// <summary>
        /// Удалить данные из справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="deletableRow">Данные для удаления</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow);

        /// <summary>
        /// Вызвать произвольную процедуру описанную в таблице META_NSIFUNCTION
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="funcId">ID функции</param>
        /// <param name="funcParams">Параметры процедуры и их значения</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Сообщение о выполнении</returns>
        string CallRefFunction(int tableId, int funcId, List<FieldProperties> funcParams);

        /// <summary>
        /// Получить дерево справочников в формате необходимом для клиентского extjs дерева
        /// </summary>
        /// <param name="appId">Код приложения (REFAPP.CODEAPP)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        List<ReferenceTreeGroupNode> GetReferenceTree(string appId);

        /// <summary>
        /// Получить данные для выбора из связанного справочника
        /// </summary>
        /// <param name="tableName">Таблица из которой нужно выбрать данные</param>
        /// <param name="fieldForId">Поле таблицы с кодом</param>
        /// <param name="fieldForName">Поле таблицы с наименованием</param>
        /// <param name="query">Строка для поиска по код+наименование</param>
        /// <param name="start">Начальная позиция (для пэйджинга)</param>
        /// <param name="limit">Количество записей для выбора (для пэйджинга)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        List<Dictionary<string, object>> GetRelatedReferenceData(string tableName, string fieldForId,
            string fieldForName, string query, int start = 0, int limit = 10);

        /// <summary>
        /// Получить условие фильтра из таблицы meta_filtercodes
        /// </summary>
        /// <param name="filterCode">Код фильтра</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        string GetFallDownCondition(string filterCode);

        /// <summary>
        /// Получить данные справочника, которые будут загружены в грид
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        GetDataResultInfo GetData(GetDataStartInfo startInfo);

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        object GetMetaData(int tableId);
    }
}