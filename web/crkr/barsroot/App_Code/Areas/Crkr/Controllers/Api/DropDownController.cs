using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;
using Dapper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class DropDownController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage ClientSex()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select * from v_sex").ToList());
            }
        }
        [HttpGet]
        public HttpResponseMessage ClientPassp()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select passp, name from v_compen_passp").ToList());
            }
        }
        [HttpGet]
        public HttpResponseMessage BenefPassp()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select passp, name from v_compen_passp_benef").ToList());
            }
        }
        [HttpGet]
        public HttpResponseMessage ClientPasspBen()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select passp, name from v_compen_passp where passp in (1,3,7,11)").ToList());
            }
        }
        [HttpGet]
        public HttpResponseMessage Countries()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select COUNTRY, NAME from V_COUNTRY").ToList());
            }
        }

        /*[HttpGet]
        public HttpResponseMessage clientpasspBurial()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select p.PASSP, p.NAME from passp p where p.passp in (96,97)").ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage clientpasspFuneral()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select p.PASSP, p.NAME from passp p where p.passp = 98 or p.passp = 95").ToList());
            }
        }*/

        [HttpGet]
        public HttpResponseMessage ClientBranch()
        {
            var sql = @"select branch, name 
                        from  branch
                        where branch like sys_context('bars_context','user_branch_mask') or sys_context('bars_context','user_mfo') = '300465' order by branch";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var result = connection.Query(sql).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
        }
        [HttpGet]
        public HttpResponseMessage ClientRez()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select * from rezid").ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage CurrentBranch()
        {
            string mfo;
            var branch = UserBranch.Branch(out mfo);
            return Request.CreateResponse(HttpStatusCode.OK, new { branch, mfo });
        }

        [HttpGet]
        public HttpResponseMessage BenefCode()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select * from COMPEN_BENEF_CODE").ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage Ob22()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("SELECT OB22, (OB22 || ' ' || TEXT) TEXT FROM COMPEN_OB22").ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage Mfo()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query("select MFO, (MFO  || ' ' || NAME) as NAME from v_banks_ru order by ru").ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage Date()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query<string>("select gl.bd from dual").SingleOrDefault());
            }
        }
       
    }
}
