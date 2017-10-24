using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    /// <summary>
    /// Additional Details Controller - save and update additional details of Zay21.
    /// </summary>
    [AuthorizeApi]
    public class AddDetailsController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public AddDetailsController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        public HttpResponseMessage Post(AdditionalDetails details)
        {
            try
            {
                _repository.SaveAdditionalDetails(details);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, 
                    new { Status = "Ok", Message = "Зміни збережено" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, 
                    new { Status = "Nok", Message = exception.Message });
            }
        }
    }
}