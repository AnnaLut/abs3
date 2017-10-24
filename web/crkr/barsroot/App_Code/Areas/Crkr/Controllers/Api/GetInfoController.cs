using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Helpers;
using Bars.Classes;
using Dapper;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class GetInfoController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetBday(string okpo)
        {
            if (!string.IsNullOrEmpty(okpo))
            {
                using (var connenction = OraConnector.Handler.UserConnection)
                {
                    return Request.CreateResponse(HttpStatusCode.OK,
                        connenction.Query<DateTime>("select get_bday_byokpo(:okpo) BDAY from dual", new {okpo})
                            .SingleOrDefault());
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetDbCode(string doctype, string ser, string numdoc)
        {
                using (var connenction = OraConnector.Handler.UserConnection)
                {
                    return Request.CreateResponse(HttpStatusCode.OK,
                        connenction.Query<string>("select crkr_compen_web.f_dbcode(:doctype, :ser, :numdoc) DBCODE from dual", new { doctype, ser, numdoc})
                            .SingleOrDefault());
            }
        }

        [HttpGet]
        public HttpResponseMessage GetSex(string okpo)
        {
            if (!string.IsNullOrEmpty(okpo))
            {
                using (var connenction = OraConnector.Handler.UserConnection)
                {
                    return Request.CreateResponse(HttpStatusCode.OK,
                        connenction.Query<string>("select get_sex_byokpo(:okpo) SEX from dual", new { okpo })
                            .SingleOrDefault());
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage ValDate()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("date", dbType: DbType.Date, direction: ParameterDirection.ReturnValue);
                connection.Execute("crkr_compen_web.get_planned_day", p, commandType: CommandType.StoredProcedure);
                var valDate = p.Get<DateTime?>("date");
                if (valDate != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, valDate);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
            }
        }
        
        [HttpGet]
        public HttpResponseMessage UserBranch()
        {
            string mfo;
            var branch = Infrastructure.Helper.UserBranch.Branch(out mfo);
            return Request.CreateResponse(HttpStatusCode.OK, branch);
        }

        [HttpGet]
        public HttpResponseMessage GetAmount(decimal rnk)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query<string>("select crkr_compen_web.GET_PAYMENT_AMOUNT(:rnk) amount from dual", new { rnk }));
            }
        }

        [HttpGet]
        public HttpResponseMessage CheckDocument(string type, string serial, string number, string eddrid, string secondary)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {

                var p = new DynamicParameters();
                p.Add("p_passp", int.Parse(type), DbType.Int16, ParameterDirection.Input);
                p.Add("p_ser", serial, DbType.String, ParameterDirection.Input);
                p.Add("p_docnum", number, DbType.String, ParameterDirection.Input);
                p.Add("p_eddr_id", eddrid, DbType.String, ParameterDirection.Input);
                p.Add("p_secondary", int.Parse(secondary), DbType.Int16, ParameterDirection.Input);
                p.Add("p_branch_name", null, DbType.String, ParameterDirection.Output,4000);
                p.Add("retval", dbType: DbType.Decimal, direction: ParameterDirection.ReturnValue);
                
                connection.Execute("crkr_compen_web.check_customer_by_document", p, commandType: CommandType.StoredProcedure);

                var retval = p.Get<decimal>("retval");
                var branch = p.Get<string>("p_branch_name");

                if (retval == 1)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, branch);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
            }
        }
    }
}
