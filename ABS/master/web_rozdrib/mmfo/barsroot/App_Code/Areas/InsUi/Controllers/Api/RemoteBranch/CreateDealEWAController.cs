using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Globalization;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    //[AuthorizeApi]
    public class CreateDealEWAController : ApiController
    {
        private readonly IInsRepository _insRepo;
        public CreateDealEWAController(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }        

        [HttpPost]
        public HttpResponseMessage Post(ParamsEwa parameters)
        {
            string res = String.Empty;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                res = _insRepo.CreateDealEWA(parameters, connection);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal nd)
        {   
            return Request.CreateResponse(HttpStatusCode.OK, "OK");
        }
    }
}
