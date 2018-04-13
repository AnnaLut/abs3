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
        public ViewResult ReferenceGrid(int? tableId, string mode, int? accessCode)
        {
            ViewBag.TableId = tableId;
            //read only by default
            int accessLevel = 1;
            if (mode == "RW")
            {
                //full access
                accessLevel = 0;
            }
            //custom access level
            if (accessCode != null)
            {
                accessLevel = accessCode.Value;
            }
            ViewBag.TableMode = accessLevel;
            return View();
        }

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <returns></returns>
        public JsonResult GetMetadata(int tableId)
        {
            try
            {
                var result = new { success = true, metadata = _repository.GetMetaData(tableId) };
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
        public ContentResult GetData(int tableId, string tableName, string gridFilter, string externalFilter, string startFilter, string fallDownFilter, string sort, int limit = 10, int start = 0)
        {
            try
            {
                var startInfo = new GetDataStartInfo
                   {
                       TableId = tableId,
                       TableName = tableName,
                       Sort = FormatConverter.JsonToObject<SortParam[]>(sort),
                       GridFilter = FormatConverter.JsonToObject<GridFilter[]>(gridFilter),
                       StartFilter = FormatConverter.JsonToObject<FieldProperties[]>(startFilter),
                       ExtFilters = FormatConverter.JsonToObject<ExtFilter[]>(externalFilter),
                       // на клиенте нет информации о условии фильтра проваливания, есть код и значения переменных, которые фигурируют в условии
                       // добавим условие фильтра проваливания
                       FallDownFilter = AddFilterCondition(FormatConverter.JsonToObject<FallDownFilterInfo>(fallDownFilter), tableName),
                       StartRecord = start,
                       RecordsCount = limit,
                       GetAllRecords = NeedToGetAllRecords(start, limit)
                   };

                GetDataResultInfo resultInfo = _repository.GetData(startInfo);
                var result = new
                {
                    data = resultInfo.DataRecords,
                    total = start + resultInfo.RecordsCount,
                    summaryData = resultInfo.TotalRecord,
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
                List<Dictionary<string, object>> allData = _repository.GetRelatedReferenceData(tableName, fieldForId, fieldForName, query, start, limit);
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
        public JsonResult CallRefFunction(int tableId, int funcId, string jsonFuncParams)
        {
            try
            {
                var funcParams = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonFuncParams);
                string resultMessage = _repository.CallRefFunction(tableId, funcId, funcParams);
                return Json(new { status = "ok", msg = resultMessage });
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
                return Json(new { status = "error", msg = "Помилка при отриманні списку довідників.\r\n" + GetErrorInfo(e) + "<br />" + e.Message });
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
        public FileContentResult ExportToExcel(int tableId, string tableName, string gridFilter, string externalFilter, string fallDownFilter, string sort, int start = 0, int limit = 10)
        {
            MemoryStream file = _repository.ExportToExcel(
                 tableId,
                 tableName,
                 FormatConverter.JsonToObject<SortParam[]>(sort),
                 FormatConverter.JsonToObject<GridFilter[]>(gridFilter),
                 FormatConverter.JsonToObject<ExtFilter[]>(externalFilter),
                 AddFilterCondition(FormatConverter.JsonToObject<FallDownFilterInfo>(fallDownFilter), tableName),
                 start,
                 limit,
                 NeedToGetAllRecords(start, limit));
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
