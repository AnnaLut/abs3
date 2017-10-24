using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models.ViewModels;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Cash.Models.ExportToExcelModels;

//using BarsWeb.Infrastructure.Helpers;

namespace BarsWeb.Areas.Cash.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    //[AuthorizeApi]
    public class LimitsDistributionAccController : ApiController
    {
        private readonly ILimitsDistributionAccRepository _repository;
        public LimitsDistributionAccController(ILimitsDistributionAccRepository repository)
        {
            _repository = repository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string date)
        {
            return _repository.GetAllToDataSourceResult(date,request);
        }

        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            int id)
        {
            return _repository.GetPlan(id).ToDataSourceResult(request);
        }
        public HttpResponseMessage Get(int id, string date)
        {
            var limDist = _repository.Get(id, date);
            return Request.CreateResponse(HttpStatusCode.OK, limDist);
        }
        static byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }
        public HttpResponseMessage Get(string date, string type)
        {
            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);
            if (type.ToUpper() == "XLSUPLOAD")
            {
                var limDist = _repository.GetAll(date).Select(i => new LimitsDistributionAccExcelForUpload
                {
                    AccId = i.Id,
                    Branch = i.Branch,
                    Kf = i.Kf,
                    AccNumber = i.AccNumber,
                    Name = i.Name,
                    Currency = i.Currency,
                    Balance = i.Balance,
                    LimitCurrent = i.LimitCurrent,
                    LimitMax = i.LimitMax,
                    CashType = i.CashType,
                    AccDateClose = i.ClosedDate
                }).OrderBy(i => i.Branch).ToList();
                var exel = new ExcelHelpers<LimitsDistributionAccExcelForUpload>(limDist, true);
                
                result.Content = new StreamContent(exel.ExportToMemoryStream());
            }
            else
            {
                var limDist = _repository.GetAll(date).Select(i => new LimitsDistributionAccExcel
                {
                    Kf = i.Kf,
                    MfoName = i.MfoName,
                    Branch = i.Branch,
                    AccNumber = i.AccNumber,
                    Name = i.Name,
                    CashType = i.CashType,
                    Currency = i.Currency,
                    Ob22 = i.Ob22,
                    LimitCurrent = i.LimitCurrent,
                    LimitMax = i.LimitMax
                }).OrderBy(i => i.Branch).ToList();
                var header = "Розподіл лімітів на рахунка на дату " + date;
                var exel = new ExcelHelpers<LimitsDistributionAccExcel>(limDist, c => c.Kf, true, header);
                
                result.Content = new StreamContent(exel.ExportToMemoryStream());
            }
            string filename = "CashLimitsDistributionAcc-" + date + ".xlsx";
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = filename
            };

            return result;
        }
        [HttpPost]
        public HttpResponseMessage Post(LimitsDistributionAccViewModel limitDistr)
        {
            var result = _repository.Add(limitDistr, FormatedDate(limitDistr.Date));
            return Request.CreateResponse(HttpStatusCode.OK, new { result.Status, result.Message });
        }
        public HttpResponseMessage Put(LimitsDistributionAccViewModel limitDistr)
        {
            var result = _repository.Edit(limitDistr, FormatedDate(limitDistr.Date));
            return Request.CreateResponse(HttpStatusCode.OK, new { result.Status, result.Message });
        }

        public HttpResponseMessage Delete(int? id, string date /*LimitsDistributionViewModel limitDistr*/)
        {
            if (id == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = "Параметр Id повинен бути заповненим" });
            }
            _repository.Delete((int)id, FormatedDate(date));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        private string FormatedDate(string date)
        {
            return date.Split(' ')[0].Replace(".", "/");
        }
    }
}