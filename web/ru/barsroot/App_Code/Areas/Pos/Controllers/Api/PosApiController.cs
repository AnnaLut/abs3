using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Pos.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Pos.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Areas.Pos.Models;

namespace BarsWeb.Areas.Pos.Controllers.Api
{
    public class PosController: ApiController
    {
        readonly IPosRepository _repo;
        public PosController(IPosRepository repo) { _repo = repo; }

        [HttpPost]
        public HttpResponseMessage PosTotalApply(IList<PosMain> obj)
        {
            try
            {
                List<decimal> res = new List<decimal>();

                BarsSql sql;
                foreach (PosMain o in obj)
                {
                    sql = SqlCreator.PosTotalApply(o.sum, o.kv, o.operation_type, o.TerminaID);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                    try
                    {
                        decimal ref_ = decimal.Parse(((OracleParameter)sql.SqlParams[4]).Value.ToString());
                        res.Add(ref_);
                    }
                    catch (Exception e) { }

                }
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
    }
}
