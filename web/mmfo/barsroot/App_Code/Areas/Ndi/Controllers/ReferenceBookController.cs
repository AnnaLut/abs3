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
using System.Web;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using BarsWeb.Areas.Ndi.Models.FilterModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers.ViewModels;
using System.Reflection;
using BarsWeb.Core.Models.Json;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers;

namespace BarsWeb.Areas.Ndi.Controllers
{
    [Authorize]
    public class ReferenceBookController : Controller
    {
        private readonly IReferenceBookRepository _repository;
        private const string ResultContentType = "text/html";
        private JsonResponse JsonResult;
        public ReferenceBookController(IReferenceBookRepository repository)
        {
            _repository = repository;
            JsonResult = new JsonResponse();
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

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UploadTemplateFile(string fieldFileName, int? tableId, int? funcId, int? codeOper, string jsonFuncParams = "", string procName = "", string msg = "",
                  string web_form_name = "", string sPar = "", string jsonSqlProcParams = "")
        {

            //string[] supportedTypes = new string[]{
            //    "png", "gif", "tiff", "bmp", "jpg", "jpeg", "htm" ,"rtf", "xml", "txt", "doc"
            //};
            try
            {

                List<FieldProperties> additionalParams = new List<FieldProperties>();
                List<FieldProperties> funcParams = FormatConverter.JsonToObject<List<FieldProperties>>(jsonFuncParams) ?? new List<FieldProperties>();

                HttpPostedFileBase postedFile = Request.Files[fieldFileName];
                if (postedFile != null)
                {
                    string x = Path.GetExtension(postedFile.FileName);

                    //if (supportedTypes.Contains(x.TrimStart('.')))
                    //{
                    BinaryReader b = new BinaryReader(postedFile.InputStream);
                    byte[] binData = b.ReadBytes(Convert.ToInt32(postedFile.ContentLength));
                    string fileName = postedFile.FileName;
                    if (fileName.Contains('\\'))
                        fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);


                    //string result = Encoding.UTF8.GetString(binData);

                    if (funcParams.Count() > 0 && funcParams.FirstOrDefault(c => c.Type == "CLOB") != null)
                        funcParams.FirstOrDefault(c => c.Type == "CLOB").Value = Encoding.UTF8.GetString(binData);
                    else
                        if (funcParams.Count() > 0 && funcParams.FirstOrDefault(c => c.Type == "BLOB") != null)
                        funcParams.FirstOrDefault(c => c.Type == "BLOB").ByteBody = binData;
                    additionalParams.Add(new FieldProperties { Name = "FileName", Value = fileName, Type = "S" });





                    string res = _repository.CallRefFunction(tableId, funcId, codeOper, null, funcParams, procName, msg, web_form_name, null, additionalParams);
                    //_repository.ExecProcWithClobParam(result, fileName, null, 0);
                    return Content("{success: 'true', resultMessage: '" + res + "'}");
                }
                string result = "{success: 'false', resultMessage: 'файл не було завантажено'}";
                return Content(result);

            }
            catch (Exception e)
            {
                return Content("{success: 'false', errorMessage: '" + e.Message + "'}");
            }
        }


        [HttpGet]
        public ViewResult GetUploadFile(int? funcId, int? tabid, string code = null)
        {
            CallFunctionMetaInfo func = null;
            if (funcId != null && tabid != null)
                func = _repository.GetCallFunction(tabid.Value, funcId.Value);
            if (func != null)
                SqlStatementParamsParser.BuildFunction(func);
            return View(func);
        }

        [HttpPost]
        public ActionResult PostUploadFile(string fileName, string date, int? tabid, int? funcid)
        {
            var file = Request.Files[0];

            try
            {

                string dirPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
                JsonResult.Message = _repository.CallParsExcelFunction(file, fileName, date, tabid, funcid);
                JsonResult.Status = JsonResponseStatus.Ok;
                return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);

            }


            catch (OracleException orex)
            {
                JsonResult.Status = JsonResponseStatus.Error;
                JsonResult.Message = orex.Message;
                JsonResult.Data = orex.Data;
            }
            catch (Exception ex)
            {
                JsonResult.Status = JsonResponseStatus.Error;
                JsonResult.Message = ex.InnerException == null ? ex.Message : ex.InnerException.Message;
            }

            return Json(JsonResult, ResultContentType, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Вывод грида с данными справочника
        /// </summary>
        /// <param name="tableId">Идентификатор справочника</param>
        /// <param name="mode">Режим достапа RO-readonly, RW-readwrite</param>
        /// <param name="accessCode">Расширеный 8уровневый режим доступа, более приоритетен предыдущего</param>
        /// <returns></returns>
        public ViewResult ReferenceGrid(int? tableId, string mode, string accessCode, string codeApp = "")
        {
            //ViewBag.TableId = tableId;
            //read only by default
            MetaCallSettings metaCallSettings = null;
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
            MainOptionsViewModel tableViwModel = new MainOptionsViewModel();
            tableViwModel.TableMode = accessLevel;
            tableViwModel.TableId = tableId;
            if (!string.IsNullOrEmpty(codeApp) && tableId.HasValue)
                metaCallSettings = _repository.GetMetaCallSettingsByAppCodeAndTabid(codeApp, tableId.Value);
            if (metaCallSettings != null && !string.IsNullOrEmpty(metaCallSettings.CODE))
                tableViwModel.Code = metaCallSettings.CODE;
            return View("ReferenceGrid", tableViwModel);
        }

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <param name="data">Модель для получения метаданных</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult GetMetadata(string data)
        {
            if (data == null) throw new ArgumentNullException("data");
            try
            {
                GetMetadataModel metaData = FormatConverter.JsonToObject<GetMetadataModel>(data);// JsonConvert.DeserializeObject<GetMetadataModel>(data) as GetMetadataModel;

                object result = new { success = true, metadata = _repository.GetMetaData(metaData) };
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
        /// <param name="data">Модель для получения данных</param>
        /// <param name="limit">Количество строк, которые должны быть отображены на странице (с сервера тянем на 1 больше для пэйджинга)</param>
        /// <param name="start">С какой строки начинать отбирать данные</param>
        /// <returns></returns>
        //public ContentResult GetData(int tableId, string tableName, string gridFilter, string externalFilter, string startFilter, string dynamicFilter, string sort, int limit = 10,
        //    int start = 0, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null, string jsonSqlProcParams = "",
        //    string base64jsonSqlProcParams = "", string filterCode = "", string executeBeforFunc = "", int? filterTblId = null, string kindOfFilter = "", bool isResetPages = false)
        public ContentResult GetData(DataModel data)
        {
            try
            {
                if (data == null) throw new ArgumentNullException("data");
                // new GetDataModel();// FormatConverter.JsonToObject<GetDataModel>(data);
                GetDataResultInfo resultInfo = _repository.GetData(data);
                var result = new
                {
                    data = resultInfo.DataRecords.Take(data.Limit),
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


        //public ActionResult GetCustomImg()
        //{
        //    byte[] res = _repository.GetCustomImage();
        //    return File(res.ToArray(), "image/png");
        //}
        public ActionResult GetRefBookData(RequestMolel requestModel)
        {
            try
            {
                Logger.Debug(string.Format(" begin GetRefBookData for: accessCode: {0},tableName: {1}, jsonSqlParams: {2},sPar: {3},sParColumn: {4},nativeTabelId: " +
                " {5}, RowParamsNames{6} ", requestModel.AccessCode.HasValue ? requestModel.AccessCode.Value.ToString() : "", requestModel.TableName, requestModel.JsonSqlParams, requestModel.Spar.HasValue ? requestModel.Spar.Value.ToString() : "",
                requestModel.SparColumn.HasValue ? requestModel.SparColumn.Value.ToString() : "", requestModel.NativeTabelId.HasValue ? requestModel.NativeTabelId.Value.ToString() : "", requestModel.RowParamsNames), LoggerPrefix + "GetMetaData");

                RequestProvider requestProvider = new RequestProvider(_repository);
                MainOptionsViewModel tableViwModel = requestProvider.BuildResponseViewModel(requestModel);

                Logger.Debug(string.Format(" end GetRefBookData for: accessLevel: {0},tableName: {1}, jsonSqlParams: {2},sPar: {3},sParColumn: {4},nativeTabelId: {5}, RowParamsNames{6} ",
                    tableViwModel.TableMode, requestModel.TableName, requestModel.JsonSqlParams, requestModel.Spar.HasValue ? requestModel.Spar.Value.ToString() : "",
                    requestModel.SparColumn.HasValue ? requestModel.SparColumn.Value.ToString() : "", requestModel.NativeTabelId.HasValue ? requestModel.NativeTabelId.Value.ToString() : "", requestModel.RowParamsNames), LoggerPrefix + "GetMetaData");
                return View("ReferenceGrid", tableViwModel);
            }
            catch (Exception e)
            {
                var result = new { status = "error", errorMessage = e.Message };
                return Content(JsonConvert.SerializeObject(result));
            }
        }

        /// <summary>
        /// Получить данные для выбора из связанного справочника
        /// </summary>
        /// <param name="tableName">Таблица из которой нужно выбрать данные</param>
        /// /// <param name="tableName">Таблица из которой нужно выбрать данные</param>
        /// <param name="fieldForId">Поле таблицы с кодом</param>
        /// <param name="fieldForName">Поле таблицы с наименованием</param>
        /// <param name="query">Строка для поиска по код+наименование</param>
        /// <param name="start">Начальная позиция (для пэйджинга)</param>
        /// <param name="limit">Количество записей для выбора (для пэйджинга)</param>
        /// <returns></returns>
        public ContentResult GetRelatedReferenceData(int? nativeTableId, string tableName, string fieldForId, string fieldForName, string query, int start = 0, int limit = 10)
        {
            try
            {

                if (string.IsNullOrEmpty(tableName))
                    throw new Exception("значення вьюшки порожне");

                List<Dictionary<string, object>> allData;
                var metaTable = _repository.GetMetaTableByName(tableName);
                ParamMetaInfo refParam = _repository.GetDefaultRelatedData(metaTable);
                if ((string.IsNullOrEmpty(fieldForId) || fieldForId == "undefined") && (string.IsNullOrEmpty(fieldForName) || fieldForName == "undefined"))
                    allData = _repository.GetRelatedReferenceData(nativeTableId, refParam.SrcTableName, refParam.SrcColName, refParam.SrcTextColName, query, refParam.SrcTextColName2, start, limit);
                else
                {
                    string name2 = !string.IsNullOrEmpty(refParam.SrcTextColName2) && refParam.SrcTextColName2 != fieldForName ? refParam.SrcTextColName2 :
                        !string.IsNullOrEmpty(refParam.SrcTextColName) && refParam.SrcTextColName != fieldForName ? refParam.SrcTextColName : null;
                    allData = _repository.GetRelatedReferenceData(nativeTableId, tableName, fieldForId, fieldForName, query, name2, start, limit);
                }
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


        public ContentResult GerSrcQueryData(string srcQueryModel, string query, int start = 0, int limit = 10)
        {
            try
            {
                if (string.IsNullOrEmpty(srcQueryModel))
                    throw new Exception("значення порожне");
                SrcQueryModel queryModel = FormatConverter.JsonToObject<SrcQueryModel>(srcQueryModel);
                List<Dictionary<string, object>> allData;
                allData = _repository.GetSrcQueryResult(queryModel, query, start, limit);
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

        public JsonResult GetFiltersMetaInfo(int tableId)
        {
            try
            {
                var filters = _repository.GetFiltersInfo(tableId);
                return Json(new { success = true, filtersInfo = filters });
            }
            catch (Exception e)
            {
                var result = new { success = false, errorMessage = e.Message };
                return Json(result);
            }

        }

        /// <summary>
        /// Обновить данные справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="editData">Модель. Параметр из тела пост запроса</param>
        /// <returns></returns>

        [HttpPost, ValidateInput(false)]
        public JsonResult UpdateData(int tableId, string tableName)
        {
            try
            {
                string req = Request.Form["editData"];

                EditRowModel editDataModel = FormatConverter.JsonToObject<EditRowModel>(req);
                //Logger.Debug(string.Format("begin updateData for tabid: {0} tabname: {1} jsonUpdatableRowKeys: {2} jsonUpdatableRowData: {3}", 
                //    editDataModel.TableId, editDataModel.TableName, editDataModel.RowKeysToEdit, editDataModel.RowDataToEdit), LoggerPrefix + "UpdateData");
                //var updatableRowKeys = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonUpdatableRowKeys);
                //List<FieldProperties> updatableRowData = editDataModel.JsonUpdatableRowData;// JsonConvert.DeserializeObject<List<FieldProperties>>(jsonUpdatableRowData);
                bool success = _repository.EditData(tableId, tableName, editDataModel, false);
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


        public JsonResult InsertUpdateRows(int tableId, string tableName, string EditingRowsModel, string AddingRowsModel)
        {
            try
            {

                // Logger.Debug(string.Format("begin updateData for tabid: {0} tabname: {1} jsonUpdatableRowKeys: {2} jsonUpdatableRowData: {3}", tableId, tableName, jsonUpdatableRowKeys, jsonUpdatableRowData), LoggerPrefix + "UpdateData");
                var edintingRows = JsonConvert.DeserializeObject<List<EditRowModel>>(EditingRowsModel);
                var addingRowsModel = JsonConvert.DeserializeObject<List<AddRowModel>>(AddingRowsModel);
                bool success = _repository.InsertUpdateRows(tableId, tableName, edintingRows, addingRowsModel);
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


        public JsonResult DeleteRows(int tableId, string tableName, string deletingRowsModel)
        {
            try
            {
                var deletingRows = JsonConvert.DeserializeObject<List<DeleteRowModel>>(deletingRowsModel);
                bool success = _repository.DeleteRows(tableId, tableName, deletingRows);
                if (success)
                {
                    string msg = deletingRows.Count + " рядків успішно видалені";
                    return Json(new { status = "ok", msg = msg });
                }
                return Json(new { status = "error", msg = "Помилка при видаленні даних.\r\n" });
            }
            catch (Exception e)
            {

                return Json(new { status = "error", msg = "Помилка при видаленні даних.\r\n" + e.Message });
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
        [HttpPost]
        public JsonResult InsertFilter(string insertUpdatetModel)
        {
            try
            {
                string req = Request.Form["insertUpdateModel"];
                InsertFilterModel filterModel = JsonConvert.DeserializeObject<InsertFilterModel>(req);
                filterModel.JosnStructure = JsonConvert.SerializeObject(filterModel.FilterRows);
                if ((filterModel.FilterRows == null || filterModel.FilterRows.Count <= 0) && string.IsNullOrEmpty(filterModel.Clause))
                    return Json(new { status = "error", msg = "не заданно данних в фільтрі" });
                if (string.IsNullOrEmpty(filterModel.FilterName))
                    return Json(new { status = "error", msg = "назва фільтра не задана" });

                foreach (FilterRowInfo item in filterModel.FilterRows)
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
                string whereClause = _repository.InsertFilter(filterModel.FilterRows, filterModel.JosnStructure, filterModel.TableId, filterModel.FilterName, filterModel.SaveFilter, filterModel.Clause);
                if (filterModel.SaveFilter == 1)
                {
                    if (!string.IsNullOrEmpty(whereClause))
                    {
                        return Json(new { status = "ok", msg = "Фільтр успішно додано" });
                    }
                    else
                        errorMsg = "Виникла помилка при збереженні фільтра\r\n";
                }
                else
                    if (filterModel.SaveFilter == 0)
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
        [HttpPost]
        public JsonResult UpdateFilter(string insertUpdateModel)
        {
            try
            {
                string req = Request.Form["insertUpdateModel"];
                EditFilterModel editFilterModel = FormatConverter.JsonToObject<EditFilterModel>(req);
                List<FilterRowInfo> filterRows = editFilterModel.FilterRows;
                editFilterModel.JosnStructure = FormatConverter.ObjectToJsom(filterRows);
                if (filterRows == null || filterRows.Count <= 0)
                    return Json(new { status = "error", msg = "не заданно данних в фільтрі" });
                if (string.IsNullOrEmpty(editFilterModel.TableName))
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
                string whereClause = _repository.UpdateFilter(editFilterModel);

                if (!string.IsNullOrEmpty(whereClause))
                {
                    return Json(new { status = "ok", msg = "Параметри фільтра успішно змінено" });
                }
                else
                    errorMsg = "Виникла помилка при редагуванні фільтра\r\n";

                return Json(new { status = "error", msg = errorMsg });
            }
            catch (Exception e)
            {

                return Json(new { status = "error", msg = "Помилка при редагуванні фільтра.<br />" + e.Message });
            }
        }


        //public JsonResult GetFilterStructure(int filterId)
        //{
        //    _repository.GetFilterStructure(filterId);
        //}
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
        public JsonResult CallRefFunction(int? tableId, int? funcId, string jsonFuncParams, int? codeOper, int? columnId, string procName = "", string msg = "",
            string web_form_name = "", string sPar = "", string base64ExternProcParams = "")
        {

            try
            {
                string jsonExtProcParameters = FormatConverter.ConvertFromUrlBase64UTF8(base64ExternProcParams);
                List<FieldProperties> funcParams = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonFuncParams);
                if (!string.IsNullOrEmpty(jsonExtProcParameters))
                {
                    List<FieldProperties> extParameters = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonExtProcParameters);
                    funcParams.AddRange(extParameters.Where(x => !funcParams.Select(c => c.Name).Contains(x.Name)));
                }

                string resultMessage = _repository.CallRefFunction(tableId, funcId, codeOper, columnId, funcParams, procName, msg, web_form_name);
                return Json(new { status = "ok", msg = resultMessage });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult CallFunctionWithResult(int? tableId, int? funcId, int? codeOper, string jsonFuncParams = "", string procName = "", string msg = "",
            string web_form_name = "", string sPar = "", string base64JExternProcParams = "")
        {
            try
            {

                List<FieldProperties> jsonSqlProcParameter;
                List<FieldProperties> funcParams = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonFuncParams);
                //if (!string.IsNullOrEmpty(jsonSqlProcParams) && jsonSqlProcParams != "undefined")
                //{
                //    jsonSqlProcParameter = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonSqlProcParams);
                //    funcParams.AddRange(jsonSqlProcParameter.Where(x => !funcParams.Select(c => c.Name).Contains(x.Name)));
                //}
                GetFileResult res = _repository.CallFunctionWithFileResult(tableId, funcId, codeOper, funcParams, procName, msg, web_form_name);
                if (res.Result == "ok" && (res.FileBytesBody != null) && !string.IsNullOrEmpty(res.FileName))
                    return File(res.FileBytesBody, "text/html", HttpUtility.UrlEncode(res.FileName));
                else
                    return Json(new { status = "error", message = res.Result });

            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult CallFuncWithMultypleRows(int? tableId, int? funcId, string listJsonSqlProcParams, int? codeOper, int? columnId, string procName = "", string msg = "",
    string web_form_name = "", string sPar = "", string inputProcParams = "", string base64JExternProcParams = "")
        {
            try
            {
                List<CallFuncRowParam> RowsData = FormatConverter.JsonToObject<List<CallFuncRowParam>>(listJsonSqlProcParams);
                List<FieldProperties> inputParams = FormatConverter.JsonToObject<List<FieldProperties>>(inputProcParams);
                MultiRowParamsDataModel dataModel = new MultiRowParamsDataModel
                {
                    RowsData = RowsData,
                    InputParams = inputParams
                };

                string resultMessage = _repository.CallEachFuncWithMultypleRows(tableId, funcId, codeOper, columnId, dataModel, procName, msg, web_form_name);
                return Json(new { status = "ok", msg = resultMessage });
            }
            catch (Exception e)
            {
                return Json(new { status = "error", msg = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }


        public JsonResult GetFuncOnlyMetaData(int? codeOper, string code = "")
        {
            try
            {
                if (codeOper == null && string.IsNullOrEmpty(code))
                    throw new Exception("ідентифікатор процедути пустий");
                CallFunctionMetaInfo funcInfo = _repository.GetFunctionsMetaInfo(codeOper, code);
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
        public FileContentResult ExportToExcel(ExcelDataModel excelDataModel)
        {
            //string ftileName = string.IsNullOrEmpty(excelDataModel.TableName) ? "data.xlsx" : excelDataModel.TableName + "-data.xlsx";
            //string ftileName = string.IsNullOrEmpty(excelDataModel.TableName) ? "data.xlsx" : excelDataModel.TableName + "-data.xlsx";
            ExcelResulModel resultModel = null;
            try
            {
                resultModel = _repository.ExportToExcel(
             excelDataModel);
                if (!string.IsNullOrEmpty(resultModel.Path))
                {
                    if (!System.IO.File.Exists(resultModel.Path))
                    {
                        return File(Encoding.UTF8.GetBytes(string.Format("Файл не знайдено {0}", resultModel.Path)), "text/plain", "ExceptionGetFile.txt");
                    }

                    string ext = resultModel.Path.Substring(resultModel.Path.LastIndexOf('.'));
                    switch (ext)
                    {
                        case ".zip":
                            return File(System.IO.File.ReadAllBytes(resultModel.Path), "application/zip", resultModel.FileName + ".zip");
                        case ".csv":
                            return File(System.IO.File.ReadAllBytes(resultModel.Path), "attachment", Path.GetFileName(resultModel.Path));
                        default:
                            return File(System.IO.File.ReadAllBytes(resultModel.Path), "attachment", resultModel.FileName + ".xlsx");
                    }

                }
                else
                    return File(resultModel.ContentResult, resultModel.ContentType, resultModel.FileName);

                //  return File(_repository.ExportToExcel(
                //excelDataModel), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", ftileName);

            }
            catch (Exception ex)
            {
                Logger.Exception(ex);
                Logger.Error("GetExcel " + ex.Message, LoggerPrefix);
                return File(Encoding.UTF8.GetBytes(ex.Message), "text/plain", "ExceptionGetFile.txt");
            }
            finally
            {
                if (resultModel != null && !string.IsNullOrEmpty(resultModel.Path))
                    System.IO.File.Delete(resultModel.Path);

            }



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
