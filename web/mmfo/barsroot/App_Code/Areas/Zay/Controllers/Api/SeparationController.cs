using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class SeparationController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public SeparationController(ICurrencySightRepository repository)
	    {
            _repository = repository;
	    }

        [HttpPost]
        public HttpResponseMessage Post(SeparationModel item)
        {
            try
            {
                _repository.SepatationSum(item);
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = "Ok", Message = "" });
            }
            catch (ActivateCardException exception)
            {
                return Request.CreateResponse(HttpStatusCode.NotImplemented,
                    new { Status = "Error", Message = "Помилка виконання. <br/>" + exception.Message });
            }
        }
    }
}
