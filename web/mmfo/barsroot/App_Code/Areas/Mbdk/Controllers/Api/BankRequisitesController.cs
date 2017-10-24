using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using Dapper;
using Oracle.DataAccess.Client;


namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class BankRequisitesController : ApiController
    {
        public HttpResponseMessage GetLeftBankRequire()
        {
            List<string> result = new List<string>();

            var getBankName = @"select val NMKA from params where par like 'GLB-NAME'";
            var mfo = @"select val from params where par='MFO'";
            var bicode = @"select val from params where par like 'BICCODE'";
            var okpo = @"select val  OKPOA from params where par='OKPO'";
            var pb = @"select val from params where par='1_PB'";
            var outRnk = @"select val from params where par='OUR_RNK'";

            try
            {
                //object resQuery;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    var resQuery = connection.Query(getBankName);
                    result.Add(resQuery.FirstOrDefault().NMKA.ToString());

                    resQuery = connection.Query(mfo);
                    result.Add(resQuery.FirstOrDefault().VAL.ToString());

                    resQuery = connection.Query(bicode);
                    result.Add(resQuery.FirstOrDefault().VAL.ToString());

                    resQuery = connection.Query(okpo);
                    result.Add(resQuery.FirstOrDefault().OKPOA.ToString());

                    resQuery = connection.Query(pb);
                    result.Add(resQuery.FirstOrDefault().VAL.ToString());

                    resQuery = connection.Query(outRnk);
                    result.Add(resQuery.FirstOrDefault().VAL.ToString());
                }

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (NullReferenceException ex)
            {
                return Request.CreateResponse(HttpStatusCode.Conflict,
                    "Один или несколько элементов не вернул значение " + ex.Message);
            }
            catch (Microsoft.CSharp.RuntimeBinder.RuntimeBinderException ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    "Не вказано Бранч. " + ex.Message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}