using System;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.ServiceModels.Models;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    /// <summary>
    /// Сервис для миграции данных из РУ в ЦА-ГРЦ
    /// </summary>
    /// 
    //[AuthorizeApi]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class CaGrcMigrationsController : BaseProxyController
    {
        private Func<object, decimal> _invokeFunc;
        private Func<object, string> _invokeXml;

        public CaGrcMigrationsController(ICrkrRepository repositoryCrkr, ICaGrcRepository repositoryCaGrc) : base(repositoryCrkr, repositoryCaGrc) {}

        [HttpPost]
        [POST("api/cagrc/camakewiring")]
        [AuthorizeApi]
        public HttpResponseMessage CaMakeWiring(CreateWiring requestData)
        {
            _invokeFunc = _repositoryCaGrc.CaMakeWiringData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/cagrc/cadropwiring")]
        [AuthorizeApi]
        public HttpResponseMessage CaDropWiring(DeleteWiring requestData)
        {
            _invokeFunc = _repositoryCaGrc.CaDropWiringData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/cagrc/rebran")]
        [AuthorizeApi]
        public HttpResponseMessage CaRebranDeposit(RebranDeposit requestData)
        {
            _invokeFunc = _repositoryCaGrc.CaRebranDepositData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/cagrc/paymentscompen")]
        [AuthorizeApi]
        public HttpResponseMessage PaymentsCompen(XmlParam requestData)
        {
            _invokeXml = _repositoryCaGrc.PaymentsCompenData;
            return GetDataProxy(requestData, _invokeXml);
        }

        [HttpPost]
        [POST("api/cagrc/payactual")]
        [AuthorizeApi]
        public HttpResponseMessage PayActual(PayActual requestData)
        {
            _invokeFunc = _repositoryCaGrc.PaymentsActualData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/cagrc/paydeactual")]
        [AuthorizeApi]
        public HttpResponseMessage PayDeActual(PayActual requestData)
        {
            _invokeFunc = _repositoryCaGrc.PaymentsDeActualData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/cagrc/backref")]
        [AuthorizeApi]
        public HttpResponseMessage BackRef(XmlParam requestData)
        {
            _invokeXml = _repositoryCaGrc.BackRefData;
            return GetDataProxy(requestData, _invokeXml);
        }
        [HttpPost]
        [POST("api/cagrc/getsosref")]
        [AuthorizeApi]
        public HttpResponseMessage GetSosRef(XmlParam requestData)
        {
            _invokeXml = _repositoryCaGrc.GetSosRefData;
            return GetDataProxy(requestData, _invokeXml);
        }
    }
}