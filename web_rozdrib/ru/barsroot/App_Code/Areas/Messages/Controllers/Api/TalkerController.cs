using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Messages.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class TalkerController : ApiController
    {
        private readonly ITalkerRepository _repository;

        public TalkerController(ITalkerRepository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage Post(string userName, string message,int type)
        {
            _repository.SetUserMessage(userName, message, type);
            return Request.CreateResponse(HttpStatusCode.OK,new {Message="Повідомлення відправлено"} );
        }
    }
}