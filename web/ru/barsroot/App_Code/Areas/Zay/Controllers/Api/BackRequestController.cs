using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class BackRequestController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public BackRequestController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        public HttpResponseMessage Post(BackRequestModel request)
        {
            try
            {
                _repository.BackRequestFunc(request);
                return Request.CreateResponse(HttpStatusCode.OK, new {Status = "Ok", Message = "Візування відмінено!"});
            }
            catch (ActivateCardException exception)
            {
                return Request.CreateResponse(HttpStatusCode.NotImplemented,
                    new {Status = "Error", Message = "Помилка виконання. <br/>" + exception.Message});
            }
        }
    }
}