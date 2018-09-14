using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SalaryBag.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SalaryBag.Infrastructure.DI.Implementation;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.SalaryBag.Models;
using System.Text;
using System.Linq;
using System.Globalization;
using System.Net.Http.Headers;
using System.Collections.Generic;
using Bars.EAD;
using Bars.Classes;
using System.Data;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.SalaryBag.Controllers.Api
{
    public class SalaryBagController : ApiController
    {
        readonly ISalaryBagRepository _repo;
        private readonly IDbLogger _logger;
        public SalaryBagController(ISalaryBagRepository repo, IDbLogger logger)
        {
            _logger = logger;
            _repo = repo;
        }

        private string ExeptionProcessing(Exception ex)
        {
            string txt = "";
            var ErrorText = ex.Message.ToString();

            byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            ErrorText = Encoding.UTF8.GetString(strBytes);

            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (x < 0)
                return ErrorText;

            decimal oraErrNumber;
            if (!decimal.TryParse(ora, out oraErrNumber))
                return ErrorText;

            if (oraErrNumber >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > -1 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                string tmpResult = txt.Replace('ы', 'і');
                return tmpResult;
            }
            else
                return ErrorText;
        }

        #region Salary Bag
        /// <summary>
        /// _filter - where clause for main select, should be like 'where sos >= 0' 
        /// </summary>
        /// <param name="request"></param>
        /// <param name="_filter"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, SosArray _filter)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain(_filter.sos.ToList());
                var data = _repo.SearchGlobal<ZpDeals>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetAccounts(string rnk)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(rnk))
                    throw new Exception("Rnk can't bee null!");

                BarsSql sql = SqlCreator.GetAccountsByRnk(rnk);
                var data = _repo.SearchGlobal<AccountsModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage Get3570Accounts(string rnk)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(rnk))
                    throw new Exception("Rnk can't bee null!");

                BarsSql sql = SqlCreator.GetAcc3570byRnk(rnk);
                var data = _repo.SearchGlobal<AccountsModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetFs()
        {
            try
            {
                BarsSql sql = SqlCreator.GetFs();
                var data = _repo.SearchGlobal<DdlIdNameModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchTarifs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchTarifs();
                var data = _repo.SearchGlobal<TarifsModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SearchCustomers([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, SearchCustomersModel model)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchCustomers(model.rnk, model.okpo, model.name);
                var data = _repo.SearchGlobal<CustomerModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetTarifByCode(string code)
        {
            try
            {
                BarsSql sql = SqlCreator.GetTarifByCode(code);
                var data = _repo.SearchGlobal<TarifsModel>(null, sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetTarifDetails(string code)
        {
            try
            {
                BarsSql sql = SqlCreator.GetTarifDetails(code);
                var data = _repo.SearchGlobal<TarifDetails>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCustomerByRnk(string rnk)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchCustomers(rnk, null, null);
                var data = _repo.SearchGlobal<CustomerModel>(null, sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage CreateDeal(DealModel model)
        {
            try
            {
                _repo.CreateDeal(model);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage UpdateDeal(DealModel model)
        {
            try
            {
                _repo.UpdateDeal(model);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage ApproveDeal(decimal id, string comment, int sos)
        {
            try
            {
                if (sos == 5)
                    _repo.AdditionalChangeDeal(id, comment);
                else
                    _repo.ApproveDeal(id, comment);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage DeleteDeal(decimal id)
        {
            try
            {
                _repo.DeleteDeal(id);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage AuthorizeDeal(decimal id)
        {
            try
            {
                _repo.AuthorizeDeal(id);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage RejectDeal(RejectDealModel model)
        {
            try
            {
                _repo.RejectDeal(model.Id, model.Comment);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage CloseDeal(decimal id, string comment)
        {
            try
            {
                _repo.CloseDeal(id, comment);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage ReportHtml(string template, string rnk, string dateFrom, string dateTo)
        {
            string templatePath = FrxDoc.GetTemplatePathByFileName(template);
            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_rnk", TypeCode.Int32, rnk));

            if (!string.IsNullOrWhiteSpace(dateTo) && !string.IsNullOrWhiteSpace(dateFrom))
            {
                CultureInfo ci;
                ci = CultureInfo.CreateSpecificCulture("en-GB");
                ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                ci.DateTimeFormat.DateSeparator = ".";

                pars.Add(new FrxParameter("sFdat1", TypeCode.String, Convert.ToDateTime(dateFrom, ci).ToString("dd.MM.yyyy")));
                pars.Add(new FrxParameter("sFdat2", TypeCode.String, Convert.ToDateTime(dateTo, ci).ToString("dd.MM.yyyy")));
            }

            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            string resHtml = string.Empty;

            using (MemoryStream str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Html, str);

                using (StreamReader sr = new StreamReader(str))
                {
                    str.Seek(0, SeekOrigin.Begin);
                    resHtml = sr.ReadToEnd();
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultMsg = resHtml });
        }

        [HttpGet]
        public HttpResponseMessage Pay3570(string acc)
        {
            try
            {
                _repo.Pay3570(acc);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }
        #endregion

        #region Accounts 2625
        [HttpGet]
        public HttpResponseMessage Search2625Main([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string dealId)
        {
            try
            {

                BarsSql sql = SqlCreator.Search2625(dealId);
                var data = _repo.SearchGlobal<Accounts2625Model>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        /// <summary>
        /// in js need to call Search2625Main after migrate execution always!!!!!!!!!!
        /// (refresh grid !!!)
        /// </summary>
        /// <param name="dealId"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage MigrateAcc(decimal dealId)
        {
            try
            {
                _repo.MigrateAcc(dealId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        /// <summary>
        /// sos : -1 - Delete, 0 - Lock, 1 - Unlock
        /// </summary>
        /// <param name="acc"></param>
        /// <param name="sos"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage SetAccSos(decimal acc, int sos)
        {
            try
            {
                _repo.SetAccSos(acc, sos);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }
        #endregion

        #region SalaryProcessing and SalaryPayroll
        [HttpGet]
        public HttpResponseMessage SearchPayrolls([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string _filter)
        {
            //System.Threading.Thread.Sleep(5000);

            try
            {
                BarsSql sql = SqlCreator.SearchPayroll();
                sql.SqlText += _filter;

                var data = _repo.SearchGlobal<PayRollModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SearchDeals([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, ZpDealsMin model)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchDeals(model.okpo, model.nmk, model.deal_id);
                var data = _repo.SearchGlobal<ZpDealsMin>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchPayrollItems([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            try
            {
                BarsSql sql = SqlCreator.GetPayRollItems(id);

                var data = _repo.SearchGlobal<PayRollItem>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchClientsByZpDeal([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string zpDealId)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchClientsByZpDeal(zpDealId);

                var data = _repo.SearchGlobal<ClientModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetClientInfoByNls(string nls)
        {
            try
            {
                //BarsSql sql = SqlCreator.GetClientInfo(nls);

                //ClientModel data = _repo.SearchGlobal<ClientModel>(null, sql).ToList().FirstOrDefault();
                ClientModel data = _repo.SearchExistingClient(nls);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDealHistory(string id)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchDealChangesById(id);

                List<ZpDealEditHistory> data = _repo.SearchGlobal<ZpDealEditHistory>(null, sql).ToList();

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage CheckAcc(string mfo, string acc)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(mfo) || mfo.Length != 6) throw new ArgumentException("МФО не може бути пустим та повинно містити 6 цифер !");
                bool result = _repo.CheckAcc(mfo, acc);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultMsg = result ? "true" : "false", ResultObj = result });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchPayrollHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string zpDealId)
        {
            try
            {
                BarsSql sql = SqlCreator.GetHistory(zpDealId);

                var data = _repo.SearchGlobal<PayrollHistory>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetNextId(string zpId)
        {
            try
            {
                var id = _repo.GetNewPayRollId(zpId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = id });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDealAndPayRollInfo(string payRollId)
        {
            try
            {
                ZpDealInfo info = _repo.GetZpDealAndPayRollInfoByPId(payRollId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = info });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage ApprovePayroll(SignResultsPostModel results)
        {
            try
            {
                _repo.ApprovePayroll(results.payrollId, results.records == null ? null : results.records.ToList());
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage DeletePayroll(string payrollId)
        {
            try
            {
                _repo.DeletePayroll(payrollId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage CalculateComission(CalcCommissionModel model)
        {
            try
            {
                var commission = _repo.CalculateCommission(model.tarifCode, model.nls2909, model.summ);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = commission });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage GetOurMfo()
        {
            try
            {
                var _mfo = _repo.GetOwnMfo();
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = _mfo });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage AddEditPayRollDocument(PayRollDocumentModel model)
        {
            try
            {
                _repo.AddEditPayRollDocument(model);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage DeletePayRollDocument(string pId)
        {
            try
            {
                _repo.DeletePayrollDocument(pId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage DeletePayRollDocuments(ArrayOfIdsModel data)
        {
            try
            {
                _repo.DeletePayrollDocuments(data.pIds.ToList());
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage CreatePayRoll(CreatePayRollModel payroll)
        {
            try
            {
                _repo.CreatePayRoll(payroll);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage ClonePayrollDocuments(string idFrom, string idTo)
        {
            try
            {
                _repo.ClonePayrollDocuments(idFrom, idTo);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage RejectPayroll(string pId, string comment)
        {
            try
            {
                _repo.RejectPayroll(pId, comment);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage PayPayroll(SignResultsPostModel data)
        {
            try
            {
                _repo.PayPayroll(data);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }
        #endregion

        #region Import
        [HttpPost]
        public HttpResponseMessage RecieveFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;

                var httpPostedFile = HttpContext.Current.Request.Files[0];

                PostFileModel postFileModel = Newtonsoft.Json.JsonConvert.DeserializeObject<PostFileModel>(httpRequest.Form["postedObj"]);

                postFileModel.p_file_name = Path.GetFileName(httpRequest.Files[0].FileName);

                using (var binaryReader = new BinaryReader(httpPostedFile.InputStream))
                {
                    postFileModel.p_clob = binaryReader.ReadBytes(httpPostedFile.ContentLength);
                }

                if (string.IsNullOrWhiteSpace(postFileModel.p_id_dbf_type) && postFileModel.p_file_type == "DBF")
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB()
                    {
                        ResultObj = _repo.PreloadDbf(postFileModel),
                        PostFileModel = postFileModel
                    }, new MediaTypeHeaderValue("text/json"));
                }
                else
                {
                    var importResult = _repo.ImportPayrollItemsFile(postFileModel);
                    if (!string.IsNullOrWhiteSpace(importResult))
                        return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = importResult }, new MediaTypeHeaderValue("text/json"));

                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB(), new MediaTypeHeaderValue("text/json"));
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage PreloadDbf(PostFileModel postFileModel)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB()
                {
                    ResultObj = _repo.PreloadDbf(postFileModel),
                    PostFileModel = postFileModel
                },
                    new MediaTypeHeaderValue("text/json"));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage SaveDbf(PostFileModel postFileModel)
        {
            try
            {
                var importResult = _repo.ImportPayrollItemsFile(postFileModel);
                if (!string.IsNullOrWhiteSpace(importResult))
                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = importResult }, new MediaTypeHeaderValue("text/json"));

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB(), new MediaTypeHeaderValue("text/json"));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) }, new MediaTypeHeaderValue("text/json"));
            }
        }
        [HttpGet]
        public HttpResponseMessage SearchImportedFilesHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string payrollId)
        {
            try
            {
                BarsSql sql = SqlCreator.GetImportedFilesHistory(payrollId);
                var data = _repo.SearchGlobal<ImportedFileModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchImportErrorList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string fileId)
        {
            try
            {
                BarsSql sql = SqlCreator.GetImportErrorList(fileId);
                var data = _repo.SearchGlobal<ImportErrorModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage DeleteImportedFile(string fileId)
        {
            try
            {
                _repo.DeleteImportedFile(fileId);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpGet]
        public HttpResponseMessage GetImportConfigs()
        {
            try
            {
                BarsSql sql = SqlCreator.GetImportConfigs();
                var data = _repo.SearchGlobal<cfgDropDownModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #endregion

        #region EA
        [HttpGet]
        public HttpResponseMessage GetDocumentsFromEA(string rnk, string zpId, string structCodes)
        {
            zpId = zpId.Substring(0, zpId.Length - 2);
            rnk = rnk.Substring(0, rnk.Length - 2);

            try
            {
                string Kf = string.Empty;
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    using (OracleCommand cmd = connection.CreateCommand())
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT sys_context('bars_context', 'user_mfo') FROM dual";
                        cmd.CommandType = CommandType.Text;
                        Kf = Convert.ToString(cmd.ExecuteScalar());
                    }
                }

                List<Bars.EAD.Structs.Result.DocumentData> eaDocs = EADService.GetDocumentData("", Convert.ToDecimal(rnk), Convert.ToDouble(zpId), null, null, null, null, null, null, Kf);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { ResultObj = _repo.CheckDocs(eaDocs, string.IsNullOrWhiteSpace(structCodes) ? null : structCodes.Split(',').ToList()) });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage RecieveFileForEa()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;

                var uploadedFile = httpRequest.Files[0].FileName;
                var httpPostedFile = HttpContext.Current.Request.Files[0];

                byte[] fileData = null;
                using (var binaryReader = new BinaryReader(httpPostedFile.InputStream))
                {
                    fileData = binaryReader.ReadBytes(httpPostedFile.ContentLength);
                }
                var zpId = httpRequest.Form["pId"];
                var structCode = httpRequest.Form["structCode"];
                var rnk = httpRequest.Form["rnk"];

                EadPack Ep = new EadPack(new ibank.core.BbConnection());

                Ep.DOC_CREATE("SCAN", null, fileData, structCode, Convert.ToDecimal(rnk), Convert.ToDecimal(zpId));

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB(), new MediaTypeHeaderValue("text/json"));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSB() { Result = "ERROR", ErrorMsg = ExeptionProcessing(ex) }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpGet]
        public HttpResponseMessage GetStructCodes()
        {
            try
            {
                BarsSql sql = SqlCreator.GetStructCodes();
                var data = _repo.SearchGlobal<EaStructCodesDdl>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #endregion

        #region Electronic digital signature
        [HttpPost]
        public HttpResponseMessage GetDocsToSign(GetDataForSignModel data)
        {
            try
            {
                List<SignModel> res = new List<SignModel>();
                if (data.isPayroll)
                {
                    foreach (string id in data.pIds)
                    {
                        BarsSql sql = SqlCreator.GetSignDataForPayroll(id);
                        res.Add(_repo.SearchGlobal<SignModel>(null, sql).ToList().FirstOrDefault());
                    }
                }
                else
                {
                    BarsSql sql = SqlCreator.GetSignDataForDocs(data.pIds[0]);
                    res = _repo.SearchGlobal<SignModel>(null, sql).ToList();
                }

                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCurrentUserSubjectSN()
        {
            try
            {
                var data = _repo.SearchGlobal<string>(null, new BarsSql()
                {
                    SqlText = "select zp.get_user_key_id() from dual",
                    SqlParams = new object[] { }
                }).ToList().FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #endregion
    }
}
