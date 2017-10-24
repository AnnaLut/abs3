using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Areas.Security.Models.Enums;
using BarsWeb.Core.Infrastructure;
using Ninject;

namespace BarsWeb.Areas.Security.Attributes
{
    public class AuthorizeApiAttribute : AuthorizeAttribute
    {
        private string _message = "";
        private readonly IAccountRepository _accountRepository;

        public AuthorizeApiAttribute()
        {
            var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
            var kernel = ninjectKernel.GetKernel();
            _accountRepository = kernel.Get<IAccountRepository>();
        }

        public AuthorizeApiAttribute(IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
        }

        protected override bool IsAuthorized(HttpActionContext context)
        {
            var headers = context.Request.Headers;
            var isAuthorized = base.IsAuthorized(context);
            if (!isAuthorized)
            {
                if (headers.Authorization != null)
                {
                    string scheme = headers.Authorization.Scheme.ToUpper();
                    if (scheme == "BASIC" || scheme == "HASHPASSWORD")
                    {
                        string userName;
                        string password;
                        if (!string.IsNullOrEmpty(headers.Authorization.Parameter))
                        {
                            var parametrer = Convert.FromBase64String(headers.Authorization.Parameter);
                            var array = System.Text.Encoding.Default.GetString(parametrer).Split(':');
                            userName = array[0];
                            password = array[1];
                        }
                        else
                        {
                            userName = headers.GetValues("UserName").FirstOrDefault();
                            password = headers.GetValues("Password").FirstOrDefault();
                        }

                        AuthorizedStatus register;
                        if (scheme == "BASIC")
                        {
                            register = _accountRepository.Authorize(userName, password);
                        }
                        else
                        {
                            register = _accountRepository.AuthorizeByHash(userName, password);
                        }
                        if (register.Status == AuthorizedStatusCode.Ok ||
                            register.Status == AuthorizedStatusCode.SelectDate)
                        {
                            return true;
                        }
                        _message = register.Message;
                    }
                    if (HttpContext.Current.User.Identity.IsAuthenticated)
                    {
                        return true;
                    }
                }

                return false;
            }
            return true;
        }
        protected override void HandleUnauthorizedRequest(HttpActionContext actionContext)
        {
            if (actionContext == null)
            {
                throw new ArgumentNullException("actionContext");
            }

            actionContext.Response =
                actionContext.ControllerContext.Request.CreateErrorResponse(
                    HttpStatusCode.Unauthorized,
                    string.IsNullOrEmpty(_message) ? "Користувач не авторизований" : _message);
        }
    }
}
