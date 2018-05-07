using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Models.Enums;

namespace BarsWeb.Areas.Security.Controllers.Api.V1
{
    public class LoginController : ApiController
    {
        private readonly IAccountRepository _accountRepository;
        public LoginController(IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
        }

        public HttpResponseMessage Get(string userName, string password)
        {
            return Post(userName, password);
        }

        public HttpResponseMessage Post(string userName, string password)
        {
            var authorize = _accountRepository.Authorize(userName, password);
            HttpStatusCode statusCode = HttpStatusCode.BadRequest;
            switch (authorize.Status)
            {
                case AuthorizedStatusCode.Error:
                    statusCode = HttpStatusCode.BadRequest;
                    break;
                case AuthorizedStatusCode.PasswordExpire:
                    statusCode = HttpStatusCode.BadRequest;
                    break;
                case AuthorizedStatusCode.SelectDate:
                    statusCode = HttpStatusCode.OK;
                    break;
                case AuthorizedStatusCode.Ok:
                    statusCode = HttpStatusCode.OK;
                    break;
            }
            return Request.CreateResponse(statusCode, new{ Message = authorize.Message, Status = authorize.Status.ToString()} );
        }
    }
}