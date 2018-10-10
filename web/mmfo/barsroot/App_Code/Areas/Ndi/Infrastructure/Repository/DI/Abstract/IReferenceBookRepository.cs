using System;
using System.Collections.Generic;
using System.IO;
using BarsWeb.Areas.Ndi.Models;
using Areas.Ndi.Models;
using System.Data;
using Microsoft.Data.OData.Query.SemanticAst;
using BarsWeb.Areas.Ndi.Models.FilterModels;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using barsroot.core;
using BarsWeb.Areas.Ndi.Models.DbModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers.ViewModels;
using System.Web;

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
        /// <param name="columnsVisible"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="getAllRecords">Экспорт всех строк. Если указано, то игнорируются параметры <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        ExcelResulModel ExportToExcel(ExcelDataModel excelDataModel);

       
        byte [] GetCustomImage();

        /// <summary>
        /// Обновить данные справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="updatableRowKeys">Значениями ключевых полей по которым выполнять update (используется оптимистическая блокировка)</param>
        /// <param name="updatableRowData">Новые значения полей, которые были изменены</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool EditData(int tableId, string tableName, EditRowModel editDataModel, bool multipleUse = false);


        bool InsertUpdateRows(int tableId, string tableName, List<EditRowModel> EditingRowsModels, List<AddRowModel> AddingRowsModels);


        bool DeleteRows(int tableId, string tableName, List<DeleteRowModel> deleteRowsModels);
        /// <summary>
        /// Вставить данные в справочник
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="insertableRow">Данные для вставки для вставки</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow, bool isMultipleProcedure = false);

        GetFileResult CallFunctionWithFileResult(int? tableId, int? funcId, int? codeOper, 
            List<FieldProperties> jsonFuncParams, string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "");

        string InsertFilter(List<FilterRowInfo> filterRows,string filterStructure, int tableid,
            string filterName, int saveFilter,string whereClause = null);


        string UpdateFilter(EditFilterModel editFilterModel);

        string InsertFilters(List<CreateFilterModel> filterModels);

        FiltersMetaInfo GetFiltersInfo(int tableId, IEnumerable<ColumnMetaInfo> columnsInfo = null);
        //string GetFilterStructure(int dynFilterId);
        /// <summary>
        /// Удалить данные из справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="deletableRow">Данные для удаления</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow, bool isMultipleProcedure = false);

        /// <summary>
        /// Вызвать произвольную процедуру описанную в таблице META_NSIFUNCTION
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="funcId">ID функции</param>
        /// <param name="funcParams">Параметры процедуры и их значения</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Сообщение о выполнении</returns>
       string CallRefFunction(int? tableId, int? funcId,int? codeOper,int? columnId, List<FieldProperties> jsonFuncParams, 
            string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "", List<FieldProperties> addParams = null);

        string CallParsExcelFunction(HttpPostedFileBase excelFile, string fileName, string date,int? tabid,int? funcid);
        string CallEachFuncWithMultypleRows(int? tableId, int? funcId, int? codeOper, int? columnId, MultiRowParamsDataModel dataModel, string funcText = "", string msg = "", string web_form_name = "", string ListjsonSqlProcParams = "");
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
        List<Dictionary<string, object>> GetRelatedReferenceData(int? nativeTableId, string tableName, string fieldForId,
            string fieldForName, string query,string tableName2 = null, int start = 0, int limit = 10);

        ParamMetaInfo GetDefaultRelatedData(MetaTable srcTable);
        List<Dictionary<string, object>> GetSrcQueryResult(SrcQueryModel srcQueryModel, string query, int start, int limit);
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
        GetDataResultInfo GetData(DataModel data);

       // DataSet ArchiveGrid(string kodf);
        
        /// <summary>
        /// Получить составной параметр sPar(аналог центуры), из поля funcName в таблицеoperlist
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        string GetFunNSIEditFParamsString(int? tableId, int? codeOper, int? metacolumnId, int? nativeTabelId,int? nsiTableId, int? nsiFuncId= null,string code = null);

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <param name="data">Модель для получения метаданных</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        object GetMetaData(GetMetadataModel data);

        MetaCallSettings GetMetaCallSettingsByCode(string code);

        MetaCallSettings GetMetaCallSettingsByAppCodeAndTabid(string appCode,int tabId);
        FunNSIEditFParams GetNsiParams(string nsiParamString, int? baseCodeOper = null, List<FieldProperties> rowParams = null);
        CallFunctionMetaInfo GetFunctionsMetaInfo(int? codeOper, string code = "");
        CallFunctionMetaInfo GetCallFunction(int tableId, int funcid);
        MetaTable GetMetaTableByName(string name);
        string GetFirstKeyName(int tabId);
        string GetSelectName(int tabid);
        MetaTable GetMetaTableById(int id);
    }
}