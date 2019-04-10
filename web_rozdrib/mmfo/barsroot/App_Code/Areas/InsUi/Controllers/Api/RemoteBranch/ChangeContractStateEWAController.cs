using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using Newtonsoft.Json.Linq;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    //[AuthorizeApi]
    public class ChangeContractStateEWAController : ApiController
    {
        private readonly IInsRepository _insRepo;
        public ChangeContractStateEWAController(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }

        [HttpGet]
        public HttpResponseMessage SendAccsStatus(int id, string state)
        {
            string res = string.Empty;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                res = _insRepo.SendAccStatus(id, state);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var rdr = new StreamReader(ex.Response.GetResponseStream()))
                    {
                        string error = rdr.ReadToEnd();
                        res = string.IsNullOrEmpty(error) ? ex.Message : Convert.ToString(JObject.Parse(error)["message"]);
                    }
                }
                else
                {
                    res = ex.Message;
                }
                return Request.CreateResponse(HttpStatusCode.InternalServerError, res);
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message + e.StackTrace);
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }
        }
    }
}
