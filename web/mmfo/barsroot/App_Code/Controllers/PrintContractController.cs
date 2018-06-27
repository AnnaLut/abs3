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
using System.IO;
using Bars.Exception;
using Bars.EAD;
using ibank.core;
using FastReport.Utils;
using Ionic.Zip;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    public class PrintContractController : Controller
    {
        //decimal? AgrID;

        //decimal argId = 0;

        #region Properties

        public string GlobalOption
        {
            get
            {
                if (Session["GlobalOption"] == null)
                    return "0";
                else
                    return Session["GlobalOption"].ToString();
            }
            set
            {
                Session["GlobalOption"] = value;
            }
        }

        public string IsDKBO
        {
            get
            {
                if (Session["multiprint_isdkbo"] == null)
                    return "";
                else
                {
                    var DKBOList = Session["multiprint_isdkbo"] as List<object>;
                    return DKBOList.FirstOrDefault().ToString();
                }
            }
            set
            {
                Session["multiprint_isdkbo"] = value;
            }
        }

        public List<object> ACCList
        {
            get
            {
                if (Session["multiprint_id"] == null)
                    return null;
                else
                    return Session["multiprint_id"] as List<object>;
            }
            set
            {
                Session["multiprint_id"] = value;
            }
        }

        public string[] StructCodes
        {
            get
            {
                if (Session["structCodes"] == null)
                    return null;
                else
                    return Session["structCodes"] as string[];
            }
            set
            {
                Session["structCodes"] = value;
            }
        }

        public string[] TemplateNames
        {
            get
            {
                if (Session["templateNames"] == null)
                    return null;
                else
                    return Session["templateNames"] as string[];
            }
            set
            {
                Session["templateNames"] = value;
            }
        }

        //public long[] Ids
        //{
        //    get
        //    {
        //        if (Session["ids"] == null)
        //            return null;
        //        else
        //            return Session["ids"] as long[];
        //    }
        //    set
        //    {
        //        Session["ids"] = value;
        //    }
        //}

        long P_ND
        {
            get
            {
                if (Session["p_nd"] == null)
                    return 0;
                else
                    return long.Parse(Session["p_nd"].ToString());
            }
            set
            {
                Session["p_nd"] = value;
            }
        }



        public List<decimal> ArgIds
        {
            get
            {
                if (Session["argIds"] == null)
                    return null;
                else
                    return Session["argIds"] as List<decimal>;
            }
            set
            {
                Session["argIds"] = value;
            }
        }


        public decimal ArgId
        {
            get
            {
                if (Session["argId"] == null)
                    return 0;
                else
                    return decimal.Parse(Session["argId"].ToString());
            }
            set
            {
                Session["argId"] = value;
            }
        }

        /// <summary>
        /// Включити роботу функцыоаналу ДКБО ЕА
        /// </summary>
        public bool DKBOEA_ON
        {
            get
            {
                if (Session["DKBOEA_ON"] == null)
                    return false;
                else
                    return Convert.ToBoolean(Session["DKBOEA_ON"]);
            }
            set
            {
                Session["DKBOEA_ON"] = value;
            }
        }



        #endregion



        private void GetGlobalOption(ref bool multiSelection)
        {
            //ViewBag.IsDKBO = IsDKBO;

            if (!multiSelection)
            {
                multiSelection = true;
            }

            using (EntitiesBars entities = new EntitiesBarsCore().NewEntity())
            {
                if (ACCList.Count == 1)
                {
                    ArgId = entities.ExecuteStoreQuery<long>(
                                "select deal_id from w4_dkbo_web where acc_acc = :acc", ACCList.FirstOrDefault().ToString()).FirstOrDefault();
                }     
            }


            using (var entity = new EntitiesBarsCore().NewEntity())
            {
                GlobalOption = entity.ExecuteStoreQuery<string>("select getglobaloption('OWENABLEEA') from dual").FirstOrDefault();

                DKBOEA_ON = (GlobalOption != "1") ? false : (IsDKBO == "1");
                   
            }
        }

        public ActionResult Index(bool multiSelection = false)
        {
            //ViewBag.IsDKBO = false;

            if (IsDKBO == "1")
            {
                GetGlobalOption(ref multiSelection);
            }
            else
            {
                DKBOEA_ON = false;
            }

            ViewBag.DKBOEA_ON = DKBOEA_ON;

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
            ViewBag.DKBOEA_ON = DKBOEA_ON;

            if (IsDKBO == "1")
            {
                GetGlobalOption(ref multiSelection);
            }

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

                string sqlText = "";


                if (!DKBOEA_ON)
                {  
                    sqlText = ServicesClass.GetSelectStryng(
                        entity,
                        rowName: " a.ID, a.NAME ",
                        typeSeach: "DOC_SCHEME ",
                        filterString: combinedFilter,
                        sort: gridParam.Sort,
                        sortDir: gridParam.SortDir,
                        pageNum: gridParam.PageNum,
                        pageSize: gridParam.PageSize);
                }
                else
                {
                    /*sqlText = @"SELECT DISTINCT wdw.nd,
                                wdw.rnk,
                                DKBO_ID,
                                DKBO_NUMBER,
                                a.id,
                                a.name,
                                ebp.GET_ARCHIVE_DKBO_DOCID (wdw.acc,
                                                            wdw.rnk,
                                                            wd.struct_code,
                                                            wd.doc_id)
                                    AS state,
                                wd.STRUCT_CODE FROM (
                                SELECT product_code,
                                nd,
                                cust_rnk rnk,
                                DKBO_DATE_FROM,
                                DKBO_DATE_TO,
                                DKBO_ID,
                                DKBO_NUMBER,
                                acc_acc acc
                            FROM W4_DEAL_WEB
                            WHERE acc_acc = :acc) wdw,
                        w4_product wp,
                        w4_product_doc wd,
                        doc_scheme a
                    WHERE wd.grp_code = wp.grp_code
                        AND wdw.product_code = wp.code
                        AND wd.doc_id NOT LIKE '%MIGR%'
                        AND wd.TYPE = 1
                        AND a.id = wd.doc_id";*/

                    sqlText = ServicesClass.GetSelectStryng(
                            entity,
                            rowName: @" DISTINCT wdw.nd,
                                wdw.rnk,
                                DKBO_ID,
                                DKBO_NUMBER,
                                a.id,
                                a.name,
                                ebp.GET_ARCHIVE_DKBO_DOCID(wdw.acc,
                                                            wdw.rnk,
                                                            wd.struct_code,
                                                            wd.doc_id)
                                    AS state,
                                wd.STRUCT_CODE FROM(
                                SELECT product_code,
                                nd,
                                cust_rnk rnk,
                                DKBO_DATE_FROM,
                                DKBO_DATE_TO,
                                DKBO_ID,
                                DKBO_NUMBER,
                                acc_acc acc
                            FROM W4_DEAL_WEB
                            WHERE acc_acc = :acc) wdw,
                        w4_product wp,
                        w4_product_doc wd,
                        doc_scheme a
                    WHERE wd.grp_code = wp.grp_code
                        AND wdw.product_code = wp.code
                        AND wd.doc_id NOT LIKE '%MIGR%'
                        AND wd.TYPE = 1
                        AND a.id = wd.doc_id ",
                            typeSeach: "",
                            filterString: "", //combinedFilter,
                            sort: "", //gridParam.Sort,
                            sortDir: "", //gridParam.SortDir,
                            pageNum: gridParam.PageNum,
                            pageSize: gridParam.PageSize);


                }
                
                if (DKBOEA_ON)
                {
                    string filters = "";
                    if (!string.IsNullOrWhiteSpace(gridParam.Filter))
                    {
                        filters = " and " + gridParam.Filter;
                    }

                    contractList = entity.ExecuteStoreQuery<DocSchemeReport>(
                                sqlText.Replace("FROM  a", "") + filters, ACCList.FirstOrDefault().ToString()).ToList();
                }
                else
                { 
                    contractList = entity.ExecuteStoreQuery<DocSchemeReport>(sqlText).ToList();
                }
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
            var serviceResult = service.GetFileForPrint(id, templateId, null);

            return serviceResult.Text;
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
        public JsonResult SetUpCreditOptions(decimal[] ids, decimal maxSum, decimal? desiredSum, decimal? installedSum)
        {
            if (maxSum > 0)
            {
                EntitiesBars entities = new EntitiesBarsCore().NewEntity();
                foreach (var acc in ids)
                {
                    object[] parameters =
                    {
                        new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                        new OracleParameter("maxSum", OracleDbType.Varchar2).Value = maxSum,
                        new OracleParameter("lim", OracleDbType.Decimal).Value = maxSum*100
                    };
                    entities.ExecuteStoreCommand(@"
                    begin                   
                        accreg.setAccountwParam(:acc, 'MAXCRSUM', :maxSum);
                        update accounts set lim = :lim where acc = :acc; 
                    end;", parameters);

                    parameters = new[]
                    {
                        new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                        new OracleParameter("desSum", OracleDbType.Varchar2).Value = desiredSum ?? 0
                    };
                    entities.ExecuteStoreCommand("begin accreg.setAccountwParam(:acc, 'DESCRSUM', :desSum); end;",
                        parameters);

                    parameters = new[]
                    {
                        new OracleParameter("acc", OracleDbType.Decimal).Value = acc,
                        new OracleParameter("insSum", OracleDbType.Varchar2).Value = installedSum ?? 0
                    };
                    entities.ExecuteStoreCommand("begin accreg.setAccountwParam(:acc, 'SETCRSUM', :insSum); end;",
                        parameters);
                    entities.ExecuteStoreCommand(
                        "begin accreg.setAccountwParam(:acc, 'PRPCRSUM', f_sumpr(:insSum * 100,'980','F')); end;",
                        parameters);
                }
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



        //----------------------------------------------------------->


        public JsonResult CreateReportFileEA(long[] ids, string[] templates, string[] structCodes, string date = "")
        {
            if (ids == null || ids.Length == 0)
            {
                throw new ApplicationException("Не задані коди договорів");
            }

            if (templates == null || templates.Length == 0)
            {
                throw new ApplicationException("Не задані шаблони договорів");
            }

            if (structCodes == null || structCodes.Length == 0)
            {
                throw new ApplicationException("Не задані структурні коди");
            }

            //Ids = ids;
            TemplateNames = templates;
            StructCodes = structCodes;


            string templateName = templates[0];

            long p_nd = ids[0];

            //-----------------------------------------------------------------------
            using (EntitiesBars entities = new EntitiesBarsCore().NewEntity())
            {
                foreach (var acc in ids)
                {
                    Session["AgrID"] = entities.ExecuteStoreQuery<long>(
                                "select deal_id from w4_dkbo_web where acc_acc = :acc", acc).FirstOrDefault();
                }
            }

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
 
            
            Session["templateName"] = templateName;
            P_ND = p_nd;
            //-------------------------------------------------------------------------
            Session["multiprint_file_ea"] = templatePath;

            return Json(true, JsonRequestBehavior.AllowGet);
        }


        //public FileResult DownloadReportFileEA()
        //{
        //    string templatePath = Session["multiprint_file_ea"].ToString();
        //    string templateName = Session["templateName"].ToString();
        //    long p_nd = long.Parse(Session["p_nd"].ToString());

        //    var rnk_list = Session["multiprint_rnk"] as List<object>;

        //    decimal? strCode = decimal.Parse(StructCodes[0]);
        //    decimal? rnk = decimal.Parse(rnk_list.FirstOrDefault().ToString());
        //    decimal? argid = decimal.Parse(Session["AgrID"].ToString());

        //    EadPack ep = new EadPack(new BbConnection());

        //    decimal? DocID = ep.DOC_CREATE("DOC", templateName, null, strCode, rnk, argid);


        //    Session["multiprint_file_ea"] = null;
            

        //    if (string.IsNullOrWhiteSpace(templatePath))
        //    {
        //        throw new ApplicationException("Файл звіту не створений");
        //    }
        //    //return File(templatePath, "application/zip", "MainReport.zip");
        //    FrxParameters pars = new FrxParameters();
        //    pars.Add(new FrxParameter("p_nd", TypeCode.Int64, p_nd));
        //    pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(DocID.Value)));
        //    FrxDoc doc = new FrxDoc(
        //    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(templateName)), pars, null);

        //    using (var str = new MemoryStream())
        //    {
        //        doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
        //        string app_type = "application/pdf";
        //        string file_type = ".pdf";
        //        return File(str.ToArray(), app_type, string.Format("report_{0}" + file_type, "example"));
        //    }
        //}


        public FilePathResult DownloadReportFileEA()
        {
            //string tempDirectory = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());

            string nameDirectory = "EA_" + DateTime.Now.ToString("yyyyMMddHHmmss");
            string tempDirectory = Path.Combine(Path.GetTempPath(), nameDirectory);

            //Directory.CreateDirectory(tempDirectory1);

            Directory.CreateDirectory(tempDirectory);
            
            List<string> templatePaths = new List<string>();
            List<string> filesToZip = new List<string>();

            

            var rnk_list = Session["multiprint_rnk"] as List<object>;
            decimal? rnk = decimal.Parse(rnk_list.FirstOrDefault().ToString());

            //using (EntitiesBars entities = new EntitiesBarsCore().NewEntity())
            //{
            //    argId = entities.ExecuteStoreQuery<long>(
            //                    "select deal_id from w4_dkbo_web where acc_acc = :acc", P_ND).FirstOrDefault();
            //}

            EadPack ep = new EadPack(new BbConnection());

            
            for (int i = 0; i < TemplateNames.Length; i++)
            {
                string templateName = TemplateNames[i];
                string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
                templatePaths.Add(templatePath);

                decimal? strCode = decimal.Parse(StructCodes[i]);

                decimal? DocID = ep.DOC_CREATE("DOC", templateName, null, strCode, rnk, ArgId, P_ND); 
                //decimal? DocID = ep.DOC_CREATE("DOC", templateName, null, strCode, rnk, ArgId);

                FrxParameters pars = new FrxParameters();
                pars.Add(new FrxParameter("p_nd", TypeCode.Int64, P_ND));
                pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(DocID.Value)));

                FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(templateName)), pars, null);

                using (var str = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                    string fileName = tempDirectory + "/" + templateName + "_report.pdf";

                    FileInfo file = new FileInfo(fileName);

                    if (file.Exists)
                    {
                        file.Delete();
                    }

                    using (var fileStream = new FileStream(fileName, FileMode.CreateNew, FileAccess.ReadWrite))
                    {
                        str.Position = 0;
                        str.CopyTo(fileStream); 
                    }

                    filesToZip.Add(fileName);
                }
            }

            string zipPath = tempDirectory + "/" + nameDirectory + ".zip";

            using (ZipFile zip = new ZipFile())
            {
                zip.AddFiles(filesToZip, false, "");            
                zip.Save(zipPath);
            }

            filesToZip.Clear();

            //Session["multiprint_file_ea"] = null;

            if (string.IsNullOrWhiteSpace(zipPath))
            {
                throw new ApplicationException("Файл звіту не створений");
            }

            //try
            //{
            return File(zipPath, "application/zip", "MyZipFile.zip");
            //}
            //catch (IOException ex)
            //{

            //}
            //finally
            //{
            //    //var dir = new DirectoryInfo(tempDirectory);
            //    //dir.Delete(true);
            //}


            
        }





        [HttpPost]
        public JsonResult SignDoc(decimal DocID)
        {
            EadPack ep = new EadPack(new BbConnection());
            JsonResult jr_success = Json(new { success = true });
            JsonResult jr_error = Json(new { error = true });

            try
            {
                ep.DOC_SIGN(DocID);
                return jr_success;
            }
            catch (Exception)
            {
                return jr_error;
            }
            finally
            {
                ep.CloseConnection();
            }                 
        } 


        //-----------------------------------------------------------<

        [HttpPost]
        public FileResult GetFile(/*List<string> templates long[] ids, string[] templates*/)
        {
            string templateName = "ACC_1_BPK_ZAYAVA_NEW_FRX"; //"ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX";
            string app_type = string.Empty;
            string file_type = string.Empty;
            int RNK = 95483601;
            int p_nd = 1961901;

            //templateName = templates.FirstOrDefault() + "_FRX";

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);

            FrxParameters pars = new FrxParameters();
            //if (DocID.HasValue)
            //{
            //    pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(DocID.Value)));
            //}

            //if (RNK.HasValue)
            //{
            //    pars.Add(new FrxParameter("rnk", TypeCode.Decimal, RNK));
            //}
            //if (AgrID.HasValue)
            //{
                pars.Add(new FrxParameter("p_nd", TypeCode.Int64, p_nd));
            //}
            //if (AgrUID.HasValue)
            //{
            //    pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, AgrUID));
            //}


            //foreach (FrxParameter par in this.AddParams)
            //    pars.Add(par);

            FrxDoc doc = new FrxDoc(
            FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(templateName)), pars, null);

            //try
            //{
            //    FrxDoc doc = new FrxDoc(
            //    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(templateName)), pars, null);

            //    var str = new MemoryStream();
            //    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
            //    app_type = "application/pdf";
            //    file_type = ".pdf";

            //    return File(str.ToArray(), app_type, string.Format("report_{0}" + file_type, "example"));
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            //finally
            //{

            //}


            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                app_type = "application/pdf";
                file_type = ".pdf";
                return File(str.ToArray(), app_type, string.Format("report_{0}" + file_type, "example"));
            }
        }
    }
}