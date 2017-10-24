using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    public class BaseProxyController : ApiController
    {
        protected readonly ICrkrRepository _repositoryCrkr;
        protected readonly ICaGrcRepository _repositoryCaGrc;
        public BaseProxyController(ICrkrRepository repositoryCrkr, ICaGrcRepository repositoryCaGrc)
        {
            _repositoryCrkr = repositoryCrkr;
            _repositoryCaGrc = repositoryCaGrc;
        }

        /// <summary>
        /// Универсальный метод для вызова Oracle процедур
        /// </summary>
        /// <typeparam name="T">Тип конкретной модели данных, которую передают в сервис</typeparam>
        /// <param name="requestData">Значения данных конкретной модели</param>
        /// <param name="invokeFunc">Ссылка на метод с Oracle процедурой</param>
        /// <returns>Статус код, а так же decimal код. Либо статус код и текстовое сообщение в случае ошибки</returns>
        [AuthorizeApi]
        public HttpResponseMessage GetDataProxy<T, N>(T requestData, Func<object, N> invokeFunc)
        {
            if (requestData == null)
                throw new Exception("Входной параметр не содержит данных");
            try
            {
                var outputCode = invokeFunc(requestData);
                return Request.CreateResponse(HttpStatusCode.OK, outputCode);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
