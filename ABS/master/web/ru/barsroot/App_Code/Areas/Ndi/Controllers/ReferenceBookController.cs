using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Ndi.Models;
using Newtonsoft.Json;
using System.Text;
using BarsWeb.Core.Logger;
using Ninject;
using System.Net.Http;
using System.Net;
using System.Web;

namespace BarsWeb.Areas.Ndi.Controllers
{
    [AuthorizeUser]
    public class ReferenceBookController : Controller
    {
        private readonly IReferenceBookRepository _repository;

        public ReferenceBookController(IReferenceBookRepository repository)
        {
            _repository = repository;
        }
        [Inject]
        public IDbLogger Logger { get; set; }
        string LoggerPrefix = "ReferenceBookController";
        /// <summary>
        /// Вывод списка справочников с возможностью перехода
        /// </summary>
        /// <param name="appId">Код приложения (REFAPP.CODEAPP)</param>
        /// <returns></returns>
        public ViewResult ReferenceList(string appId)
        {
            ViewBag.AppId = appId;
            return View();
        }

        /// <summary>
        /// Вывод грида с данными справочника
        /// </summary>
        /// <param name="tableId">Идентификатор справочника</param>
        /// <param name="mode">Режим достапа RO-readonly, RW-readwrite</param>
        /// <param name="accessCode">Расширеный 8уровневый режим доступа, более приоритетен предыдущего</param>
        /// <returns></returns>
        public ViewResult ReferenceGrid(int? tableId, string mode, string accessCode)
        {
            ViewBag.TableId = tableId;
            //read only by default
            string accessLevel = AccessParams.WithoutUpdate.ToString();
            if (mode == "RW")
            {
                //full access
                accessLevel = AccessParams.FullUpdate.ToString();
            }
            //custom access level
            if (accessCode != null)
            {
                accessLevel = accessCode;
            }
            ViewBag.TableMode = accessLevel;
            return View();
        }

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <returns></returns>
        public JsonResult GetMetadata(int tableId, int? CodeOper, int? sParColumn, int? nativeTabelId, int? nsiTableId, int? nsiFuncId, string base64jsonSqlProcParams = "")
        {
            try
            {
                var result = new { success = true, metadata = _repository.GetMetaData(tableId, CodeOper, sParColumn, nativeTabelId, nsiTableId, nsiFuncId, base64jsonSqlProcParams) };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, errorMessage = e.Message };
                return Json(result);
            }
        }

        /// <summary>
        /// Получить данные справочника, которые будут загружены в грид
        /// </summary>
        /// <param name="tableId">id таблицы, с которой тянуть данные</param>
        /// <param name="tableName">название таблицы, с которой тянуть данные (чтобы заново не вычитывать из БД)</param>
        /// <param name="gridFilter">json с информацией о фильтрах по колонкам грида</param>
        /// <param name="startFilter">Фильтр диалоговый при старте, перед населением таблицы</param>
        /// <param name="externalFilter">json с информацией о внешних фильтрах</param>
        /// <param name="fallDownFilter">json с информацией о дополнительных фильтрах для вычитки данных (используется при проваливании из другого справочника)</param>
        /// <param name="sort">json с информацией о сортировке</param>
        /// <param name="limit">Количество строк, которые должны быть отображены на странице (с сервера тянем на 1 больше для пэйджинга)</param>
        /// <param name="start">С какой строки начинать отбирать данные</param>
        /// <returns></returns>
        public ContentResult GetData(int tableId, string tableName, string gridFilter, string CustomFilters, string externalFilter, string startFilter, string dynamicFilter, string sort, int limit = 10,
            int start = 0, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null, string jsonSqlProcParams = "",
            string base64jsonSqlProcParams = "", string filterCode = "", string executeBeforFunc = "", int? filterTblId = null, string kindOfFilter = "", bool isReserPages = false)
        {
            try
            {
                GetDataResultInfo resultInfo = _repository.GetData(tableId, tableName, gridFilter, externalFilter, startFilter, dynamicFilter, sort, limit, start, nativeTabelId, codeOper,
                    sParColumn, nsiTableId, nsiFuncId, jsonSqlProcParams, base64jsonSqlProcParams, executeBeforFunc, filterTblId, kindOfFilter, filterCode, isReserPages);
                var result = new
                {
                    data = resultInfo.DataRecords.Take(limit),
                    total = resultInfo.RecordsCount,
                    summaryData = resultInfo.TotalRecord,
                    status = "ok"
                };
                return Content(JsonConvert.SerializeObject(result));
            }
            catch (Exception e)
            {

                var result = new { status = "error msg:  ", errorMessage = e.Message.ToUpper() };
                return Content(JsonConvert.SerializeObject(result));
            }
        }

        public ActionResult GetCustomImg()
        {
            byte[] res = _repository.GetCustomImage();
            return File(res.ToArray(), "image/png");
        }
        public ActionResult GetRefBookData(int? accessCode, string tableName = "", string jsonSqlParams = "", int? sPar = null, int? sParColumn = null, int? nativeTabelId = null,
            int? nsiTableId = null, int? nsiFuncId = null, string RowParamsNames = "", bool hasCallbackFunction = false, string filterCode = "", string jsonTblFilterParams = "", bool getFiltersOnly = false)
        {
            FunNSIEditFParams nsiEditParams = null;
            Logger.Debug(string.Format(" begin GetRefBookData for: accessCode: {0},tableName: {1}, jsonSqlParams: {2},sPar: {3},sParColumn: {4},nativeTabelId: {5}, RowParamsNames{6} ", accessCode.HasValue ? accessCode.Value.ToString() : "", tableName, jsonSqlParams, sPar.HasValue ? sPar.Value.ToString() : "", sParColumn.HasValue ? sParColumn.Value.ToString() : "", nativeTabelId.HasValue ? nativeTabelId.Value.ToString() : "", RowParamsNames), LoggerPrefix + "GetMetaData");
            List<FieldProperties> RowParams = string.IsNullOrEmpty(jsonSqlParams) || jsonSqlParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(jsonSqlParams) as List<FieldProperties>;
            bool isFuncOnly = false;
            string FunNSIEditFParamsString = _repository.GetFunNSIEditFParamsString(null, sPar, sParColumn, nativeTabelId, nsiTableId, nsiFuncId);
            if (!string.IsNullOrEmpty(FunNSIEditFParamsString))
            {
                nsiEditParams = new FunNSIEditFParams(FunNSIEditFParamsString);
                nsiEditParams.ReplaceParams(RowParams);
            }

            tableName = nsiEditParams == null || string.IsNullOrEmpty(nsiEditParams.TableName) ? tableName : nsiEditParams.TableName;
            if (string.IsNullOrEmpty(tableName) && nsiEditParams != null && nsiEditParams.IsFuncOnly)
                isFuncOnly = true;
            var meta_table = _repository.GetMetaTableByName(tableName);
            ViewBag.TableId = meta_table != null ? meta_table.TABID.ToString() : (nativeTabelId != null && nativeTabelId.HasValue ? nativeTabelId.Value.ToString() : "");
            ViewBag.CodeOper = sPar;
            ViewBag.sParColumn = sParColumn;
            string accessLevel = AccessParams.WithoutUpdate.ToString();
            //custom access level
            if (accessCode != null && accessCode.HasValue)
                accessLevel = AccessSettings.GetAll().FirstOrDefault(u => (int)u == accessCode).ToString();

            if (nsiEditParams != null && nsiEditParams.ACCESS_CODE.HasValue)
                accessLevel = AccessSettings.GetAll().FirstOrDefault(u => (int)u == nsiEditParams.ACCESS_CODE).ToString();
            ViewBag.filterCode = filterCode;
            ViewBag.hasCallbackFunction = hasCallbackFunction;
            ViewBag.nativeTabelId = nativeTabelId != null && nativeTabelId.HasValue ? nativeTabelId.ToString() : "";
            ViewBag.TableMode = accessLevel;
            var bytes = Encoding.UTF8.GetBytes(jsonSqlParams);
            ViewBag.base64jsonSqlProcParams = Convert.ToBase64String(bytes);
            ViewBag.isFuncOnly = isFuncOnly;
            ViewBag.nsiTableId = nsiTableId;
            ViewBag.nsiFuncId = nsiFuncId;
            ViewBag.getFiltersOnly = getFiltersOnly;
            Logger.Debug(string.Format(" end GetRefBookData for: accessLevel: {0},tableName: {1}, jsonSqlParams: {2},sPar: {3},sParColumn: {4},nativeTabelId: {5}, RowParamsNames{6} ", accessLevel, tableName, jsonSqlParams, sPar.HasValue ? sPar.Value.ToString() : "", sParColumn.HasValue ? sParColumn.Value.ToString() : "", nativeTabelId.HasValue ? nativeTabelId.Value.ToString() : "", RowParamsNames), LoggerPrefix + "GetMetaData");

            return View("ReferenceGrid");
        }

        /// <summary>
        /// Получить данные для выбора из связанного справочника
        /// </summary>
        /// <param name="tableName">Таблица из которой нужно выбрать данные</param>
        /// <param name="fieldForId">Поле таблицы с кодом</param>
        /// <param name="fieldForName">Поле таблицы с наименованием</param>
        /// <param name="query">Строка для поиска по код+наименование</param>
        /// <param name="start">Начальная позиция (для пэйджинга)</param>
        /// <param name="limit">Количество записей для выбора (для пэйджинга)</param>
        /// <returns></returns>
        public ContentResult GetRelatedReferenceData(string tableName, string fieldForId, string fieldForName, string query, int start = 0, int limit = 10)
        {
            try
            {
                ParamMetaInfo refParam;
                List<Dictionary<string, object>> allData;
                if(string.IsNullOrEmpty(tableName))
                    throw new  Exception("значення вьюшки порожне");
                if (!string.IsNullOrEmpty(tableName) && (string.IsNullOrEmpty(fieldForId) || fieldForId == "undefined") && (string.IsNullOrEmpty(fieldForName) || fieldForName == "undefined"))
                {
                    refParam = SqlStatementParamsParser.GetDefaultRelatedData(tableName);
                    allData = _repository.GetRelatedReferenceData(refParam.SrcTableName, refParam.SrcColName, refParam.SrcTextColName, query, start, limit);
                }
                else
                    allData = _repository.GetRelatedReferenceData(tableName, fieldForId, fieldForName, query, start, limit);
                var result = new
                {
                    data = allData.Take(limit),
                    total = start + allData.Count(),
                    status = "ok"
                };
                return Content(JsonConvert.SerializeObject(result));
            }
            catch (Exception e)
            {
                var result = new { status = "error", errorMessage = e.Message };
                return Content(JsonConvert.SerializeObject(result));
            }
        }

        //public ContentResult GetCustomFilterData(int tableId,string kindOfFilter,string tableName)
        //{

        //}

        /// <summary>
        /// Обновить данные справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="jsonUpdatableRowKeys">json cо значениями ключевых полей по которым выполнять update (используется оптимистическая блокировка)</param>
        /// <param name="jsonUpdatableRowData">json c новыми значениями полей, которые были изменены</param>
        /// <returns></returns>
        public JsonResult UpdateData(int tableId, string tableName, string jsonUpdatableRowKeys, string jsonUpdatableRowData)
        {
            try
            {
                Logger.Debug(string.Format("begin updateData for tabid: {0} tabname: {1} jsonUpdatableRowKeys: {2} jsonUpdatableRowData: {3}", tableId, tableName, jsonUpdatableRowKeys, jsonUpdatableRowData), LoggerPrefix + "UpdateData");
                var updatableRowKeys = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonUpdatableRowKeys);
                var updatableRowData = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonUpdatableRowData);
                bool success = _repository.UpdateData(tableId, tableName, updatableRowKeys, updatableRowData);
                if (success)
                {
                    return Json(new { status = "ok", msg = "Дані успішно оновлені" });
                }
                return Json(new { status = "error", msg = "Виникла помилка при оновленні даних.\r\n Можливо цей рядок заблокований для редагування або інший користувач змінив дані цього рядка" });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = "Помилка при оновленні даних.\r\n" + e.Message });
            }
        }

        /// <summary>
        /// Вставить данные в справочник
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="jsonInsertableRow">json c данными для вставки</param>
        /// <returns></returns>
        public JsonResult InsertData(int tableId, string tableName, string jsonInsertableRow)
        {
            try
            {
                var insertableRow = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonInsertableRow);
                bool success = _repository.InsertData(tableId, tableName, insertableRow);
                if (success)
                {
                    return Json(new { status = "ok", msg = "Новий рядок успішно додано" });
                }
                return Json(new { status = "error", msg = "Виникла помилка при оновленні даних.\r\n" });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = "Помилка при оновленні даних.<br />" + GetErrorInfo(e) + "<br />" + e.Message });
            }
        }

        public JsonResult InsertFilter(int tableId, string tableName, string parameters, string filterName = "фильтер1", int saveFilter = 1, string clause = null)
        {
            try
            {

                List<FilterRowInfo> filterRows = JsonConvert.DeserializeObject<List<FilterRowInfo>>(parameters);
                if ((filterRows == null || filterRows.Count <= 0) && string.IsNullOrEmpty(clause))
                    return Json(new { status = "error", msg = "не заданно данних в фільтрі" });
                if (string.IsNullOrEmpty(filterName))
                    return Json(new { status = "error", msg = "назва фільтра не задана" });

                foreach (FilterRowInfo item in filterRows)
                {
                    if (string.IsNullOrEmpty(item.Colname) && string.IsNullOrEmpty(item.LogicalOp) && string.IsNullOrEmpty(item.ReletionalOp) && string.IsNullOrEmpty(item.Value))
                        return Json(new { status = "error", msg = "строка не заповнена" });
                    if (item.Colname == null)
                        item.Colname = "";
                    if (item.LogicalOp == null)
                        item.LogicalOp = "";
                    if (item.ReletionalOp == null)
                        item.ReletionalOp = "";
                    if (item.Value == null)
                        item.Value = "";
                }
                string errorMsg = "";
                string whereClause = _repository.InsertFilter(filterRows, tableId, filterName, saveFilter, clause);
                if (saveFilter == 1)
                {
                    if (!string.IsNullOrEmpty(whereClause))
                    {
                        return Json(new { status = "ok", msg = "Фільтр успішно додано" });
                    }
                    else
                        errorMsg = "Виникла помилка при збереженні фільтра\r\n";
                }
                else
                    if (saveFilter == 0)
                    {
                        if (!string.IsNullOrEmpty(whereClause))
                        {
                            var result = new { clause = whereClause };
                            return Json(new { status = "ok", msg = whereClause });
                        }
                        else
                            errorMsg = "Виникла помилка при застосуванні фільтра\r\n";
                    }
                return Json(new { status = "error", msg = errorMsg });
            }
            catch (Exception e)
            {

                return Json(new { status = "error", msg = "Помилка при при збереженні фільтра.<br />" + e.Message });
            }


        }

        public JsonResult InsertFilters(List<CreateFilterModel> filterModels)
        {
            return null;
            //try
            //{

            //    List<FilterRowInfo> filterRows = JsonConvert.DeserializeObject<List<FilterRowInfo>>(parameters);
            //    if ((filterRows == null || filterRows.Count <= 0) && string.IsNullOrEmpty(clause))
            //        return Json(new { status = "error", msg = "не заданно данних в фільтрі" });
            //    if (string.IsNullOrEmpty(filterName))
            //        return Json(new { status = "error", msg = "назва фільтра не задана" });

            //    foreach (FilterRowInfo item in filterRows)
            //    {
            //        if (string.IsNullOrEmpty(item.Colname) && string.IsNullOrEmpty(item.LogicalOp) && string.IsNullOrEmpty(item.ReletionalOp) && string.IsNullOrEmpty(item.Value))
            //            return Json(new { status = "error", msg = "строка не заповнена" });
            //        if (item.Colname == null)
            //            item.Colname = "";
            //        if (item.LogicalOp == null)
            //            item.LogicalOp = "";
            //        if (item.ReletionalOp == null)
            //            item.ReletionalOp = "";
            //        if (item.Value == null)
            //            item.Value = "";
            //    }
            //    string errorMsg = "";
            //    string whereClause = _repository.InsertFilter(filterRows, tableId, filterName, saveFilter, clause);
            //    if (saveFilter == 1)
            //    {
            //        if (!string.IsNullOrEmpty(whereClause))
            //        {
            //            return Json(new { status = "ok", msg = "Фільтр успішно додано" });
            //        }
            //        else
            //            errorMsg = "Виникла помилка при збереженні фільтра\r\n";
            //    }
            //    else
            //        if (saveFilter == 0)
            //        {
            //            if (!string.IsNullOrEmpty(whereClause))
            //            {
            //                var result = new { clause = whereClause };
            //                return Json(new { status = "ok", msg = whereClause });
            //            }
            //            else
            //                errorMsg = "Виникла помилка при застосуванні фільтра\r\n";
            //        }
            //    return Json(new { status = "error", msg = errorMsg });
            //}
            //catch (Exception e)
            //{

            //    return Json(new { status = "error", msg = "Помилка при при збереженні фільтра.<br />" + e.Message });
            //}
        }
        /// <summary>
        /// Удалить данные из справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="jsonDeletableRow">json c данными для удаления</param>
        /// <returns></returns>
        public JsonResult DeleteData(int tableId, string tableName, string jsonDeletableRow)
        {
            try
            {
                var deletableRow = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonDeletableRow);
                bool success = _repository.DeleteData(tableId, tableName, deletableRow);
                if (success)
                {
                    return Json(new { status = "ok", msg = "Рядок успішно видалено" });
                }
                return Json(new { status = "error", msg = "Виникла помилка при оновленні даних.\r\n" });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = "Помилка при оновленні даних.\r\n" + GetErrorInfo(e) + "<br />" + e.Message });
            }
        }

        /// <summary>
        /// Вызвать произвольную процедуру описанную в таблице META_NSIFUNCTION
        /// </summary>
        /// <returns></returns>
        public JsonResult CallRefFunction(int? tableId, int? funcId, string jsonFuncParams, int? codeOper,int? columnId, string procName = "", string msg = "",
            string web_form_name = "", string sPar = "", string jsonSqlProcParams = "")
        {

            try
            {
                List<FieldProperties> jsonSqlProcParameter;
                List<FieldProperties> funcParams = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonFuncParams);
                if (!string.IsNullOrEmpty(jsonSqlProcParams))
                {
                    jsonSqlProcParameter = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonSqlProcParams);
                    funcParams.AddRange(jsonSqlProcParameter.Where(x => !funcParams.Select(c => c.Name).Contains(x.Name)));
                }

                string resultMessage = _repository.CallRefFunction(tableId, funcId, codeOper,columnId, funcParams, procName, msg, web_form_name);
                return Json(new { status = "ok", msg = resultMessage });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult CallFunctionWithResult(int? tableId, int? funcId, int? codeOper, string jsonFuncParams = "", string procName = "", string msg = "",
            string web_form_name = "", string sPar = "", string jsonSqlProcParams = "")
        {
            try
            {

                List<FieldProperties> jsonSqlProcParameter;
                List<FieldProperties> funcParams = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonFuncParams);
                if (!string.IsNullOrEmpty(jsonSqlProcParams) && jsonSqlProcParams != "undefined")
                {
                    jsonSqlProcParameter = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonSqlProcParams);
                    funcParams.AddRange(jsonSqlProcParameter.Where(x => !funcParams.Select(c => c.Name).Contains(x.Name)));
                }
                GetFileResult res = _repository.CallFunctionWithFileResult(tableId, funcId, codeOper, funcParams, procName, msg, web_form_name);
                if (res.Result == "ok" && !string.IsNullOrEmpty(res.FileBody) && !string.IsNullOrEmpty(res.FileName))
                    return File(Encoding.Default.GetBytes(res.FileBody), "text/html", HttpUtility.UrlEncode(res.FileName));
                else
                    return Json(new { status = "error", message = res.Result });

            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetFuncOnlyMetaData(int? codeOper)
        {
            try
            {
                CallFunctionMetaInfo funcInfo = _repository.GetFunctionsMetaInfo(codeOper);
                var result = new { success = true, funcMetaInfo = funcInfo };
                return Json(result);

            }
            catch (Exception e)
            {

                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Получить дерево справочников в формате необходимом для клиентского extjs дерева
        /// </summary>
        /// <param name="appId">Код приложения (REFAPP.CODEAPP)</param>
        /// <returns></returns>
        public JsonResult GetReferenceTree(string appId)
        {
            try
            {
                List<ReferenceTreeGroupNode> referenceGroups = _repository.GetReferenceTree(appId);
                var result = new { children = referenceGroups };
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = "Помилка прstring[] columnsVisibleи отриманні списку довідників.\r\n" + GetErrorInfo(e) + "<br />" + e.Message });
            }
        }

        /// <summary>
        /// Выполнить экспорт в Excel
        /// </summary>
        /// <param name="tableName"></param>
        /// <param name="gridFilter"></param>
        /// <param name="externalFilter"></param>
        /// <param name="fallDownFilter"></param>
        /// <param name="sort"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="tableId"></param>
        /// <returns></returns>
        public FileContentResult ExportToExcel(int tableId, string tableName, string gridFilter,
           string startFilter, string dynamicFilter,
           string externalFilter, string fallDownFilter,
           string columnsVisible, string sort, int start = 0, int limit = 10, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null, string jsonSqlProcParams = "", string base64jsonSqlProcParams = "", string executeBeforFunc = "")
        {
            MemoryStream file = _repository.ExportToExcel(
                 tableId, tableName,
                 sort, gridFilter, startFilter, dynamicFilter, externalFilter,
                 columnsVisible, start, limit, nativeTabelId, codeOper, sParColumn,
                 nsiTableId, nsiFuncId, jsonSqlProcParams, base64jsonSqlProcParams, executeBeforFunc);
            return File(file.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "data.xlsx");
        }

        /// <summary>
        /// Определить нужно ли вычитывать все строки для заданных параметров 
        /// </summary>
        /// <param name="start">Начиная со строки</param>
        /// <param name="limit">Количество строк</param>
        /// <returns>Отбирать все строки</returns>
        private bool NeedToGetAllRecords(int start, int limit)
        {
            // если клиент запросил больше 1000 строк - будем вычитаем все
            return limit >= 1000;
        }

        /// <summary>
        /// Дополнить фильтр проваливания условием фильтра
        /// </summary>
        /// <param name="fallDownFilter">Информация о фильтре проваливания</param>
        /// <param name="tableName"></param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        private FallDownFilterInfo AddFilterCondition(FallDownFilterInfo fallDownFilter, string tableName)
        {
            if (fallDownFilter == null)
            {
                return null;
            }
            string condition = _repository.GetFallDownCondition(fallDownFilter.FilterCode);
            if (string.IsNullOrEmpty(condition))
            {
                throw new InvalidOperationException(string.Format("Фільтр з кодом '{0}' не знайдений", fallDownFilter.FilterCode));
            }
            fallDownFilter.Condition = condition.Replace("$~~ALIAS~~$", tableName);
            return fallDownFilter;
        }

        private string GetErrorInfo(Exception e)
        {
            var pg = new ErrorPageGenerator(e);
            return pg.GetBarsErrorText();
        }
    }
}
