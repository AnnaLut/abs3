using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Bars.Web.Report;
using barsroot;
using BarsWeb.Models;
using clientregister;
using BarsWeb.HtmlHelpers;
using Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    public class PrintContractController : Controller
    {
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
        public ActionResult ContractList(JGridView.QueryParam gridParam, 
                                         string defaultFilter,
                                         string userFilter,
                                         bool multiSelection = false)
        {
            List<DocSchemeReport> contractList;
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
        
        public string GetFileForPrint(string id, string templateId)
        {
            var service = new defaultWebService();
            string fileName = service.GetFileForPrint(id, templateId, null);
            return fileName;
        }
        
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

            string filePath = reporter.GetReportFile();
            Session["multiprint_file"] = filePath;
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        private bool isNeedShowDialog(string[] templates)
        {
            EntitiesBars entities = new EntitiesBarsCore().NewEntity();
            var samples = entities.ExecuteStoreQuery<string>("select doc_id from doc_dialogreq");
            return samples.Intersect(templates).Any();
        }

        //устанавливаем дополнительные опции кредита
        public JsonResult SetUpCreditOptions(decimal[] ids, decimal maxSum, decimal desiredSum, decimal installedSum)
        {
            EntitiesBars entities = new EntitiesBarsCore().NewEntity();
            foreach (var acc in ids)
            {
                object[] parameters =
                {
                    new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                    new OracleParameter("maxSum", OracleDbType.Varchar2).Value = maxSum,
                    new OracleParameter("lim", OracleDbType.Decimal).Value = maxSum * 100
                };
                entities.ExecuteStoreCommand(@"
                    begin                   
                        accreg.setAccountwParam(:acc, 'MAXCRSUM', :maxSum);
                        update accounts set lim = :lim where acc = :acc; 
                    end;", parameters);

                parameters = new[]{
                    new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                    new OracleParameter("desSum", OracleDbType.Varchar2).Value = desiredSum
                };
                entities.ExecuteStoreCommand("begin accreg.setAccountwParam(:acc, 'DESCRSUM', :desSum); end;", parameters);

                parameters = new[]{
                    new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                    new OracleParameter("insSum", OracleDbType.Varchar2).Value = installedSum
                };
                entities.ExecuteStoreCommand("begin accreg.setAccountwParam(:acc, 'SETCRSUM', :insSum); end;", parameters);
                entities.ExecuteStoreCommand("begin accreg.setAccountwParam(:acc, 'PRPCRSUM', f_sumpr(:insSum * 100,'980','F')); end;", parameters);
            }
            return Json("ok", JsonRequestBehavior.AllowGet);
        }

        //вычитаем сумму максимального кредита
        public JsonResult ReadCreditOptions(long[] ids, string[] templates)
        {
            decimal oldVal = -1;
            //если отчет не внесен в спец справочник - возвращаем -1, как индикатор того, что не требуется показывать диалог
            if (!isNeedShowDialog(templates))
            {
                return Json(new { maxSum = oldVal }, JsonRequestBehavior.AllowGet);
            }

            EntitiesBars entities = new EntitiesBarsCore().NewEntity();

            string desiredSum = "";
            string installedSum = "";
            //ищем уже внесенные первые попавшиеся параметры для счета с максимальной суммой
            foreach (var acc in ids)
            {
                if (desiredSum == "")
                {
                    desiredSum =
                        entities.ExecuteStoreQuery<string>(
                            "SELECT W.VALUE FROM accounts a, ACCOUNTSW w WHERE a.acc=W.ACC and W.TAG='DESCRSUM' and A.ACC = :acc",
                            acc).FirstOrDefault();
                }
                if (installedSum == "")
                {
                    installedSum =
                        entities.ExecuteStoreQuery<string>(
                            "SELECT W.VALUE FROM accounts a, ACCOUNTSW w WHERE a.acc=W.ACC and W.TAG='SETCRSUM' and A.ACC = :acc",
                            acc).FirstOrDefault();
                }
                var s = entities.ExecuteStoreQuery<string>("SELECT W.VALUE FROM accounts a, ACCOUNTSW w WHERE a.acc=W.ACC and W.TAG='MAXCRSUM' and A.ACC = :acc", acc).FirstOrDefault();
                decimal.TryParse(s, out oldVal);
                if (oldVal > 0)
                {
                    return (Json(new
                    {
                        maxSum = oldVal,
                        desiredSum = desiredSum,
                        installedSum = installedSum
                    }, JsonRequestBehavior.AllowGet));
                }
            }
            //вычисляем для первого счета сумму по шкале тарифов
            object[] parameters =
            {
                new OracleParameter("acc", OracleDbType.Decimal).Value = ids[0],
                new OracleParameter("acc1", OracleDbType.Decimal).Value = ids[0],
            };

            var value = entities.ExecuteStoreQuery<decimal>(
                @"select get_lim_bycardcode((select card_code from W4_ACC where acc_pk = :acc)) from w4_acc where acc_pk = :acc1", parameters).FirstOrDefault();

            oldVal = value;

            return (Json(new
            {
                maxSum = oldVal,
                desiredSum = desiredSum,
                installedSum = installedSum
            }, JsonRequestBehavior.AllowGet));
        }

        public FilePathResult DownloadReportFile()
        {
            string filePath = Session["multiprint_file"].ToString();
            Session["multiprint_file"] = null;
            if (string.IsNullOrWhiteSpace(filePath))
            {
                throw new ApplicationException("Файл звіту не створений");
            }
            return File(filePath, "application/zip", "MainReport.zip");
        }
        
        public ActionResult TestPrint()
        {
            Session["multiprint_id"] = new List<object>() { 800, 900 };
            Session["multiprint_filter"] = new List<object>() { "id like 'CUST%'" }; 
            return View();
        }
    }

}