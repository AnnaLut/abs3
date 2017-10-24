using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.ServiceModels.Models;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    //[AuthorizeApi]
    /// <summary>
    /// Сервис для миграции данных из РУ в ЦРКР
    /// </summary>
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class CrkrMigrationsController : BaseProxyController
    {
        private Func<object, decimal> _invokeFunc;
        private Func<object, string> _invokeXml;
        public CrkrMigrationsController(ICrkrRepository repositoryCrkr, ICaGrcRepository repositoryCaGrc) : base(repositoryCrkr, repositoryCaGrc) {}

        [HttpPost]
        [POST("api/crkr/datamigration")]
        [AuthorizeApi]
        public HttpResponseMessage DataMigration(HttpRequestMessage request, CrkrModel requestData)
        {
            #region OldCodeExample
            if (requestData == null || string.IsNullOrEmpty(requestData.record))
                throw new Exception("Входной параметр не содержит данных (Input values is null or empty)");

            var connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                var outputCode = _repositoryCrkr.TransportData(connection, requestData);
                return Request.CreateResponse(HttpStatusCode.OK, outputCode);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            finally
            {
                connection.Close();
            }
            #endregion
            //_invokeFunc = _repository.TransportData;
            //return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/makewiring")]
        [AuthorizeApi]
        public HttpResponseMessage MakeWiring(CreateWiring requestData)
        {
            _invokeFunc = _repositoryCrkr.MakeWiringData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/updatecompen")]
        [AuthorizeApi]
        public HttpResponseMessage UpdateWiring(CrkrModel requestData)
        {
            _invokeFunc = _repositoryCrkr.UpdateCompenData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/dropcompen")]
        [AuthorizeApi]
        public HttpResponseMessage DropCompen(DeleteCompen requestData)
        {
            _invokeFunc = _repositoryCrkr.DropCompenData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/fixcompen")]
        [AuthorizeApi]
        public HttpResponseMessage FixCompen(DeleteCompen requestData)
        {
            _invokeFunc = _repositoryCrkr.FixCompenData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/dropwiring")]
        [AuthorizeApi]
        public HttpResponseMessage DropWiring(DeleteWiring requestData)
        {
            _invokeFunc = _repositoryCrkr.DropWiringData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/countcompen")]
        [AuthorizeApi]
        public HttpResponseMessage CountCompen(CountCompen requestData)
        {
            _invokeFunc = _repositoryCrkr.CountCompenData;
            return GetDataProxy(requestData, _invokeFunc);
        }

        [HttpPost]
        [POST("api/crkr/verifycompen")]
        [AuthorizeApi]
        public HttpResponseMessage VerifyCompen(VerifyCompen requestData)
        {
            _invokeXml = _repositoryCrkr.VerifyCompenData;
            return GetDataProxy(requestData, _invokeXml);
        }
    }
}