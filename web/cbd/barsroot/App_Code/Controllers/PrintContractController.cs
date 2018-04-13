using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Bars.Web.Report;
using barsroot;
using BarsWeb.Models;
using clientregister;
using BarsWeb.HtmlHelpers;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    public class PrintContractController : Controller
    {
        /// <summary>
        /// Для корректной работы нудно заполнить переменные сессии 
        /// multiprint_id - List<object> {212, 214313, 12443} перечень через запятую кодов договоров
        /// multiprint_filter - List<object> {"id like 'CUST%'"} дополнительный фильтр отбора шаблонов договоров
        /// </summary>
        /// <param name="multiSelection">Признак множественной печати договоров. 
        /// Если печать одиночная - из переденных в сессию списков берутся первые элементы</param>
        /// <returns></returns>
        public ActionResult Index(bool multiSelection = false)
        {
            //читаем коды договоров и фильтр на шаблоны договоров из переменных сессии
            var sessionId = Session["multiprint_id"] as List<object>;
            if (sessionId == null)
            {
                throw new ApplicationException("Не задані коди договорів");
            }

            var sessionFilter = Session["multiprint_filter"] as List<object>;
            if (sessionFilter == null)
            {
                throw new ApplicationException("Не заданий фільтр на шаблони договорів");
            }

            var idList = new List<long>();
            foreach (var objId in sessionId)
            {
                long id;
                if (long.TryParse(objId.ToString(), out id))
                {
                    idList.Add(id);                        
                }
                else
                {
                    throw new ApplicationException(
                        "Невірно задані коди договорів.");
                }
            }

            //из xml-форм мы получаем не один фильтр, а список фильтров всех выбранных строк
            //если фильтры разные - нельзя определить к каким договорам какие типы относятся
            //TODO: на будущие версии сделать обработку различных фильтров на соответствие договорам
            if (multiSelection && sessionFilter.Count > 1 && sessionFilter.Distinct().Count() != 1)
            {
                throw new ApplicationException(
                    "Невірно заданий фільтр договорів.");
            }
            var filterList = new List<string>();
            foreach (var objFilter in sessionFilter)
            {
                filterList.Add(objFilter.ToString());
            }

            //передаем представлению весь список если множественная печать, и первый элемент если одиночная
            //в представлении с выбираем только шаблоны, коды договоров уже будут известны, передаем во ViewBag.Id
            if (multiSelection)
            {
                ViewBag.Id = idList;
            }
            else
            {
                ViewBag.Id = idList.FirstOrDefault();
            }
            ViewBag.Filter = filterList.FirstOrDefault();
            
            //возвращаем представление с множественным выбором или без
            if (multiSelection)
            {
                return View("IndexSelection");
            }
            return View();
        }

        /// <summary>
        /// Выводит список шаблонов договоров
        /// </summary>
        /// <param name="defaultFilter">Фильтр по умолчанию на таблицу шаблонов DOC_SCHEME</param>
        /// <param name="userFilter">Динамический пользовательский фильтр на таблицу шаблонов DOC_SCHEME</param>
        /// <param name="multiSelection">Признак вывода списка с возможностью выбора</param>
        /// <param name="pageNum"></param>
        /// <param name="pageSize"></param>
        /// <param name="sort"></param>
        /// <param name="sortDir"></param>
        /// <returns></returns>
        public ActionResult ContractList(
                                         JGridView.QueryParam gridParam, 
                                         string defaultFilter,
                                         string userFilter,
                                         bool multiSelection = false
                                         //int? pageNum = 1,
                                         //int? pageSize = 10,
                                         //string sort = "ID",
                                         //string sortDir = "ASC"
                                        )
        {
            var contractList = new List<DocSchemeReport>();
            using (var entity = new EntitiesBarsCore().NewEntity())
            {
                string combinedFilter = "";
                if (!string.IsNullOrWhiteSpace(defaultFilter))
                {
                    combinedFilter = !string.IsNullOrWhiteSpace(combinedFilter) ? combinedFilter + " and " : "";
                    combinedFilter += defaultFilter;
                }
                if (!string.IsNullOrWhiteSpace(userFilter))
                {
                    combinedFilter = !string.IsNullOrWhiteSpace(combinedFilter) ? combinedFilter + " and " : "";
                    combinedFilter += userFilter;
                }

                if (!string.IsNullOrWhiteSpace(gridParam.Filter))
                {
                    combinedFilter += (string.IsNullOrWhiteSpace(combinedFilter) ? "" : " and ") + gridParam.Filter;
                }

                string sqlText = ServicesClass.GetSelectStryng(
                    entity,
                    rowName: "a.ID, a.NAME ",
                    typeSeach: "DOC_SCHEME ",
                    filterString: combinedFilter,
                    sort: gridParam.Sort,
                    sortDir: gridParam.SortDir,
                    pageNum: gridParam.PageNum,
                    pageSize: gridParam.PageSize);

                contractList = entity.ExecuteStoreQuery<DocSchemeReport>(sqlText).ToList();
            }
            if (multiSelection)
            {
                return View("ContractListSelection", contractList);
            }
            return View(contractList);
        }

        /// <summary>
        /// Получить имя сгенерированного файла отчета для одиночной печати договоров
        /// </summary>
        /// <param name="id">Код договора</param>
        /// <param name="templateId">Код шаблона</param>
        /// <returns>Имя файла</returns>
        public string GetFileForPrint(string id, string templateId)
        {
            var service = new defaultWebService();
            string fileName = service.GetFileForPrint(id, templateId, null);
            return fileName;
        }

        /// <summary>
        /// Множественная печать договоров. Создать объединенный файл с договорами 
        /// </summary>
        /// <param name="ids">Массив кодов договоров</param>
        /// <param name="templates">Массив шаблонов договоров</param>
        /// <param name="date"></param>
        /// <returns>true - файл создали, false - не удалось</returns>
        public JsonResult CreateReportFile(long[] ids, string[] templates, string date = "")
        {
            if (ids == null || ids.Length == 0)
            {
                throw new ApplicationException("Не задані коди договорів");
            }

            if (templates == null || templates.Length == 0)
            {
                throw new ApplicationException("Не задані шаблони договорів");
            }

            var reporter = new MultiPrintRtfReporter(System.Web.HttpContext.Current)
            {
                Roles = "reporter,dpt_role,cc_doc",
                ContractNumbers = ids,
                TemplateIds = templates
            };

            //reporter.Adds = Convert.ToInt64(date);

            string filePath = reporter.GetReportFile();
            Session["multiprint_file"] = filePath;
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Загрузить файл отчета 
        /// </summary>
        /// <returns>Начнется скачивание файла</returns>
        public FilePathResult DownloadReportFile()
        {
            string filePath = Session["multiprint_file"].ToString();
            Session["multiprint_file"] = null;
            try
            {

                if (string.IsNullOrWhiteSpace(filePath))
                {
                    throw new ApplicationException("Файл звіту не створений");
                }
                return File(filePath, "application/zip", "MainReport.zip");
            }
            finally
            {
                /*try
                {
                    DirectoryInfo dirInfo = new DirectoryInfo(filePath);
                    dirInfo.Delete();
                }
                catch (Exception)
                {
                }*/
            }

        }

        //TODO: delete
        public ActionResult TestPrint()
        {
            Session["multiprint_id"] = new List<object>() { 800, 900 };
            Session["multiprint_filter"] = new List<object>() { "id like 'CUST%'" }; 
            return View();
        }
    }

}