using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;


namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    //[AuthorizeApi]
    public class UpdHistoryController : ApiController
    {
        private readonly IUpdateHistoryRepository _updHistoryRepo;
        public UpdHistoryController(IUpdateHistoryRepository updHistoryRepo)
        {
            _updHistoryRepo = updHistoryRepo;
        }

        public HttpResponseMessage Post(BarsUpdateInfo updInfo)
        {
            try
            {
                _updHistoryRepo.InsertUpdateInfo(updInfo);
            }
            catch (Exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }


        private string GetClientIp(HttpRequestMessage request = null)
        {
            request = request ?? Request;

            if (request.Properties.ContainsKey("MS_HttpContext"))
            {
                return ((HttpContextWrapper)request.Properties["MS_HttpContext"]).Request.UserHostAddress;
            }
            else if (request.Properties.ContainsKey(RemoteEndpointMessageProperty.Name))
            {
                RemoteEndpointMessageProperty prop = (RemoteEndpointMessageProperty)request.Properties[RemoteEndpointMessageProperty.Name];
                return prop.Address;
            }
            else if (HttpContext.Current != null)
            {
                return HttpContext.Current.Request.UserHostAddress;
            }
            else
            {
                return null;
            }
        }
    }
}