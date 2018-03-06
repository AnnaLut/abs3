using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Zay.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class DilerKursController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public DilerKursController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, 
            decimal mode)
        {
            try
            {
                var data = _repository.DilerKursData(mode).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }

        [HttpPost]
        public HttpResponseMessage Post(DilerKursUpdate model)
        {
            try
            {
                var responseSuccessMsgType = "";

                switch (Convert.ToInt32(model.rateType))
                {
                    case 1:
                        if (model.viewType == "1")
                        {
                            // Sale/Buy - Ind
                            _repository.UpdateDilerIndKurs(
                                model.kvCode, model.blk, model.indBuy, model.indSale, model.indBuyVip, model.indSaleVip);
                            responseSuccessMsgType = "Задано новий індикативний курс!";
                        }
                        else if (model.viewType == "2")
                        {
                            // Sale/Buy - IFact
                            _repository.UpdateDilerFactKurs(model.kvCode, model.fBuy, model.fSale);
                            responseSuccessMsgType = "Задано новий фактичний курс!";
                        }
                        break;
                    case 2:
                        if (model.conType == "1")
                        {
                            // Conversion - Ind
                            _repository.SetDilerConvKurs(1, model.pairKursF, model.pairKursS, model.newIndKurs);
                            responseSuccessMsgType = "Задано новий індикативний курс конверсії!";
                        }
                        else if (model.conType == "2")
                        {
                            // Conversion - fact
                            _repository.SetDilerConvKurs(2, model.pairKursF, model.pairKursS, model.newFactKurs);
                            responseSuccessMsgType = "Задано новий фактичний курс конверсії!";
                        }
                        break;
                    default:
                        // put msg
                        responseSuccessMsgType = "Жодний з можливих варіантів конфігурації курсів не задано!";
                        break;
                }
                
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { ResultMsg = responseSuccessMsgType });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }
    }
}