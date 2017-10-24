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
    public class LimitsDistributionAtmController : ApiController
    {
        private readonly ILimitsDistributionAtmRepository _repository;
        public LimitsDistributionAtmController(ILimitsDistributionAtmRepository repository)
        {
            _repository = repository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string date)
        {
            return _repository.GetAllToDataSourceResult(date, request);
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
        /*static byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }*/

        /// <summary>
        /// завантаження файла
        /// </summary>
        /// <param name="date">Дата</param>
        /// <param name="type">тип файла (XLS, XLSUPLOAD)</param>
        /// <returns></returns>
        public HttpResponseMessage Get(string date, string type)
        {
            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);
            if (type.ToUpper() == "XLSUPLOAD")
            {
                var limDistUpl = _repository.GetAll(date).Select(i => new LimitsDistributionAtmUpload
                {
                    AtmCode = i.AtmCode,
                    LimitMaxLoad = i.LimitMaxLoad
                }).OrderBy(i => i.AtmCode).ToList();
                var exel = new ExcelHelpers<LimitsDistributionAtmUpload>(limDistUpl, true);
                result.Content = new StreamContent(exel.ExportToMemoryStream());
            }
            else
            {
                var limDist = _repository.GetAll(date).Select(i=> new LimitsDistributionAtmExcel
                {
                    Kf=i.Kf,
                    MfoName = i.MfoName,
                    Branch = i.Branch,
                    AtmCode = i.AtmCode,
                    CashType = i.CashType,
                    AccNumber = i.AccNumber,
                    Name = i.Name,
                    Currency = i.Currency,
                    Balance = i.Balance,
                    LimitMaxLoad = i.LimitMaxLoad
                }).OrderBy(i => i.Branch).ToList();
                var header = "Розподіл лімітів на банкомати на " + date;
                var exel = new ExcelHelpers<LimitsDistributionAtmExcel>(limDist, c => c.Kf, true, header);
                result.Content = new StreamContent(exel.ExportToMemoryStream());
            }
            string filename = "CashLimitsDistributionAtm-" + date + ".xlsx";
            
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = filename
            };

            return result;
        }
        public HttpResponseMessage Put(LimitsDistributionAtmViewModel limitDistr)
        {
            _repository.Add(limitDistr, FormatedDate(limitDistr.Date));
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }
        [HttpPost]
        public HttpResponseMessage Post(LimitsDistributionAtmViewModel limitDistr)
        {
            _repository.Add(limitDistr, limitDistr.Date);
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
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