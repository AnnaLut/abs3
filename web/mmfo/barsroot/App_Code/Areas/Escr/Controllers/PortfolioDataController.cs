using System;
using System.IO;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using BarsWeb.Areas.Escr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Escr.Models;
using BarsWeb.Controllers;
using System.Linq;
using Oracle.DataAccess.Client;
using Bars.Classes;
using OfficeOpenXml;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.Wcs.Controllers
{
    [AuthorizeUser]
    public class PortfolioDataController : ApplicationController
    {
        private readonly IEscrRepository _escrRepository;
        public PortfolioDataController(IEscrRepository escrRepository)
        {
            _escrRepository = escrRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Portfolio()
        {
            return View();
        }

        public ActionResult RefList()
        {
            return View();
        }

        public ActionResult Journal()
        {
            return View();
        }

        public ActionResult GetRegisterMain([DataSourceRequest]DataSourceRequest request, string dateFrom, string dateTo, string type, string kind)
        {
            IQueryable<EscrRegisterMain> session = _escrRepository.GetRegisterMain(dateFrom, dateTo, type, kind);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetEvents(decimal customerId, decimal dealId)
        {
            IQueryable<EscrEvents> session = _escrRepository.GetEvents(customerId, dealId);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProd()
        {
            IQueryable<EscrProd> session = _escrRepository.GetProd();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetViddRee()
        {
            IQueryable<EscrViddRee> session = _escrRepository.GetVidd();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveRegister(EscrSaveRegister param)
        {
           
            try
            {
                 decimal res = _escrRepository.SaveRegister(param);
                 return Json(new { Data = res, Status = 1 }, JsonRequestBehavior.AllowGet);
            }
             catch (Exception ex)
            {
                return Json(new { Data = ex.Message, Status = 0 }, JsonRequestBehavior.AllowGet);
            }
        }




        public ActionResult GetRegister(string dateFrom, string dateTo, string type, string kind)
        {
            IQueryable<EscrRegister> session = _escrRepository.GetRegister(dateFrom, dateTo, type, kind).OrderBy(i => i.ID);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRegisterDeals(decimal registerId)
        {
            IQueryable<EscrRegisterDeals> session = _escrRepository.GetRegisterDeals(registerId);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public string SendRegister(List<decimal> registers)
        {
            var result = _escrRepository.SendRegister(registers);
            return result;
        }

        public ActionResult ExportExcel(decimal reg_id, string dateFrom, string dateTo)
        {
            var orderId = new Random();

            string templateName = "";
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select val from params$base where par = :par_";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("par_", OracleDbType.Varchar2, "ESCR_TMPLT_REP", System.Data.ParameterDirection.Input));
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    templateName = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? String.Empty : reader.GetString(0); 
                }
            
            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("sFdat1", TypeCode.String, dateFrom),
                new FrxParameter("sFdat2", TypeCode.String, dateTo),
                new FrxParameter("reg_id", TypeCode.Decimal, reg_id)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Excel2007, str);
                    _escrRepository.SetComment(reg_id, String.Empty, "CONFIRMATION_GVI", 1, 1, cmd);
                return File(str.ToArray(), "application/vnd.ms-excel", string.Format("f190_{0}.xls", orderId.Next()));
            }
        }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        [HttpPost]
        public ActionResult Import(HttpPostedFileBase files)
        {
            string content = String.Empty;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
            if (files != null)
            {
                files.InputStream.Position = 0;
                using (var package = new ExcelPackage(files.InputStream))
                {
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.First();
                    bool isError = false;
                    decimal? regId = (decimal?)null;
                    var rowCnt = worksheet.Dimension.End.Row;
                    var colCnt = worksheet.Dimension.End.Column + 1;
                    for (var r = 6; r <= rowCnt - 1; r++)
                    {
                        string dealDate = worksheet.Cells[r, 10].Value.ToString();
                        string dealNumber = worksheet.Cells[r, 11].Value.ToString();
                        decimal dealSum = Convert.ToDecimal(worksheet.Cells[r, 15].Value.ToString());
                        string okpo = worksheet.Cells[r, 3].Value.ToString();
                        string comment = String.IsNullOrEmpty((string)worksheet.Cells[r, 17].Value) ? String.Empty : worksheet.Cells[r, 16].Value.ToString();
                        if (!String.IsNullOrEmpty(comment) && !isError)
                        {
                            isError = true;
                        }
                        ImportParams param = new ImportParams();
                        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
                        ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                        ci.DateTimeFormat.DateSeparator = ".";
                        param.dealDate = Convert.ToDateTime(dealDate, ci);
                        param.dealNumber = dealNumber;
                        param.dealSum = dealSum;
                        param.okpo = okpo;
                        param.comment = comment;
                        param.regId = (decimal?)null;
                        param.dealId = (decimal?)null;
                        param.status_code = String.Empty;
                        ImportParams result = _escrRepository.GetRegDeal(param);
                        if (result.status_code == "CONFIRMED_GVI")
                        { 
                            content = "Реєстр вже імпортовано";
                            return Content(content);
                        }
                        if (!String.IsNullOrEmpty(result.comment))
                        {
                                _escrRepository.SetComment((decimal)result.dealId, result.comment, "REJECTED_GVI", 0, 0, cmd);
                        }
                        regId = (decimal)result.regId;
                    }
                    if (!isError)
                    {
                            _escrRepository.SetComment((decimal)regId, String.Empty, "CONFIRMED_GVI", 1, 1, cmd);
                        content = "";
        }
                    else 
                    {
                            _escrRepository.SetComment((decimal)regId, String.Empty, "RECEIVED", 1, 1, cmd);
                        content = "Є помилки";
                    }
                }
            }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
                
            return Content(content);
        }

        public void SetComment(decimal deal_id, string comment, string state_code, decimal object_type, decimal obj_check)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                _escrRepository.SetComment(deal_id, comment, state_code, object_type, obj_check, cmd);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void SetDocDate(decimal deal_id, string doc_date)
        {
            _escrRepository.SetDocDate(deal_id, doc_date);
        }

        public void SetNewSum(decimal deal_id, decimal? new_good_cost, decimal? new_deal_sum, decimal? new_comp_sum)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                _escrRepository.SetNewSum(deal_id, new_good_cost, new_deal_sum, new_comp_sum,cmd);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
  

        public void SetNdTxt(decimal deal_id, string tag, string value)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                _escrRepository.SetNdTxt(deal_id, tag, value,cmd);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }



        public void SetCreditState(decimal deal_id, string state_code)
        {
            _escrRepository.SetCreditState(deal_id, state_code);
        }

        public decimal GroupByRegister(GroupByParams param)
        {
            return _escrRepository.GroupByRegister(param);
        }

        public void DelGroupRegister(List<decimal> registers)
        {
            _escrRepository.DelGroupRegister(registers);
        }

        public void DelDealRegister(List<decimal> deals)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                _escrRepository.DelDealRegister(deals, cmd);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void CheckState()
        {
            //_escrRepository.CheckState();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.bars_async.run_job";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("p_job_name", OracleDbType.Varchar2, "ESCR_SYNC_STATE", System.Data.ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public ActionResult GetRefList([DataSourceRequest]DataSourceRequest request)
        {
            string Status = "ok";
            try
            {
                IQueryable<EscrRefList> session = _escrRepository.GetRefList();
                return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PayRefs(string all_rows)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
                List<decimal> all = serializer.Deserialize<List<decimal>>(all_rows);
                _escrRepository.PayOrDelete(all, 1);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult DeleteRefs(string all_rows)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
                List<decimal> all = serializer.Deserialize<List<decimal>>(all_rows);
                _escrRepository.PayOrDelete(all, 2);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult GetJournalList([DataSourceRequest]DataSourceRequest request)
        {
            string Status = "ok";
            try
            {
                IQueryable<EscrJournal> session = _escrRepository.GetJournalList();
                return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetJournalDetail([DataSourceRequest]DataSourceRequest request, decimal id)
        {
            string Status = "ok";
            try
            {
                IQueryable<EscrJournalDetail> session = _escrRepository.GetJournalDetail(id);
                return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult RestoreGLK(decimal id)
        {
            string Status = "ok";
            try
            {
                _escrRepository.RestoreGLK(id);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });

        }

    }
}