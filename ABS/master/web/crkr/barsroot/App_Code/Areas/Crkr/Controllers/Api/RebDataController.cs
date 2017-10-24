using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using System.Net;
using Dapper;
using System.Linq;
using System.Data;
using System;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class BranchesForChange
    {
        public string frombranch { get; set; }
        public string tobranch { get; set; }
    }
    public class RebDataController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Branches()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select branch, name from branch").ToList());
            }
        }

        [HttpPost]
        public HttpResponseMessage Change(BranchesForChange model)
        {
            var connection = OraConnector.Handler.UserConnection;
            string result;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_branch_from", model.frombranch, DbType.String, ParameterDirection.Input);
                p.Add("p_branch_to", model.tobranch, DbType.String, ParameterDirection.Input);
                p.Add("p_res", null, DbType.String, ParameterDirection.Output, 4000);
                connection.Execute("crkr_compen_web.rebranch_crca", p, commandType: CommandType.StoredProcedure);
                result = p.Get<string>("p_res");
                
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
    }
}

