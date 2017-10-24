using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class ImportUsersController : ApiController
    {
        private readonly IUserRepository _users;
        public ImportUsersController(IUserRepository users)
        {
            _users = users;
        }
        [HttpPost]
        public HttpResponseMessage ImportUsers(ListUsersParams param)
        {
            var result = _users.ImportUsers(param);
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
    }
}
