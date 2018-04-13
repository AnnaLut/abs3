using System;
using System.IO;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Globalization;
using BarsWeb.Areas.Escr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Escr.Models;
using BarsWeb.Controllers;
using System.Linq;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

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

        public decimal SaveRegister(EscrSaveRegister param)
        {
            return _escrRepository.SaveRegister(param);
        }

        public ActionResult GetRegister([DataSourceRequest]DataSourceRequest request, string dateFrom, string dateTo, string type, string kind)
        {
            IQueryable<EscrRegister> session = _escrRepository.GetRegister(dateFrom, dateTo, type, kind).OrderBy(i => i.ID);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRegisterDeals([DataSourceRequest]DataSourceRequest request, decimal registerId)
        {
            IQueryable<EscrRegisterDeals> session = _escrRepository.GetRegisterDeals(registerId);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
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
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
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
                //_escrRepository.SetComment(reg_id, String.Empty, "CONFIRMATION_GVI", 1, 1);
                return File(str.ToArray(), "application/vnd.ms-excel", string.Format("f190_{0}.xls", orderId.Next()));
            }
        }

        [HttpPost]
        public ActionResult Import(HttpPostedFileBase files)
        {
            string content = String.Empty;
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
                    var outNumber = worksheet.Cells[1, 17].Value.ToString();
                    for (var r = 6; r <= rowCnt; r++)
                    {
                        string dealDate = worksheet.Cells[r, 10].Value.ToString();
                        string dealNumber = worksheet.Cells[r, 11].Value.ToString();
                        decimal dealSum = Convert.ToDecimal(worksheet.Cells[r, 15].Value.ToString());
                        string okpo = worksheet.Cells[r, 3].Value.ToString();
                        string comment = String.IsNullOrEmpty((string)worksheet.Cells[r, 17].Value) ? String.Empty : worksheet.Cells[r, 17].Value.ToString();
                        bool type = String.IsNullOrEmpty((string)worksheet.Cells[r, 17].Value) ? false : worksheet.Cells[r, 18].Value.ToString() == "1" ? true : false;
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
                            _escrRepository.SetComment((decimal)result.dealId, result.comment, type ? "SENT_TO_REVISION" : "REJECTED_GVI", 0, 0);
                        }
                        else if (isError)
                        {
                            _escrRepository.SetComment((decimal)result.dealId, result.comment, "RECEIVED", 0, 0);
                        }
                        regId = (decimal)result.regId;
                    }
                    if (!isError)
                    {
                        _escrRepository.SetComment((decimal)regId, String.Empty, "CONFIRMED_GVI", 1, 1);
                        _escrRepository.SetOutNumber((decimal)regId, outNumber);
                        content = "";
                    }
                    else 
                    {
                        _escrRepository.SetComment((decimal)regId, String.Empty, "RECEIVED", 1, 0);
                        content = "Є помилки";
                    }
                }
            }
            return Content(content);
        }

        public void SetComment(decimal deal_id, string comment, string state_code, decimal object_type, decimal obj_check)
        {
            _escrRepository.SetComment(deal_id, comment, state_code, object_type, obj_check);
        }

        public void SetDocDate(decimal deal_id, string doc_date)
        {
            _escrRepository.SetDocDate(deal_id, doc_date);
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
            _escrRepository.DelDealRegister(deals);
        }

        public void CheckState()
        {
            //_escrRepository.CheckState();
        }

        public void GenRegPl(List<decimal> registers)
        {
            _escrRepository.GenRegPl(registers);
        }

        public string Validate(decimal reg_id)
        {
            return _escrRepository.Validate(reg_id);
        }

        public void SetOutNumber(decimal reg_id, string out_number)
        {
            _escrRepository.SetOutNumber(reg_id, out_number);
        }
        public void СhangeCompSum(decimal deal_id, decimal new_good_cost)
        {
            _escrRepository.СhangeCompSum(deal_id, new_good_cost);
        }
        public void SetNewSum(decimal deal_id, decimal? new_good_cost, decimal? new_deal_sum, decimal? new_comp_sum)
        {
            _escrRepository.SetNewSum(deal_id, new_good_cost, new_deal_sum, new_comp_sum);
        }
        public void DelRegEvent(decimal deal_id, decimal event_id)
        {
            _escrRepository.DelRegEvent(deal_id, event_id);
        }

    }
}