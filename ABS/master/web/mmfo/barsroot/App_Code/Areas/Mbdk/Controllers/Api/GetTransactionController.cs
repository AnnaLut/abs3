using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Models;
using Oracle.DataAccess.Client;
using Dapper;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    public class GetTransactionController : ApiController
    {
        [HttpGet]
        [GET("api/mbdk/gettransaction/gettransactionlist")]
        public HttpResponseMessage GetTransactionList(decimal nd, string nls)
        {
            try
            {
                var sql = @"SELECT d.nd, d.cc_id, d.vidd, d.vidd_name, d.tipd, d.date_end, d.date_u, d.date_v, d.s, d.s_pr, 
                                   d.a_nls, d.a_ostc/power(10,t.dig) as a_ostc, d.a_acc, d.a_tip, d.a_kv, t.name,
                                   d.b_nls, d.b_ostc/power(10,t1.dig) as b_ostc, 
                                   d.rnk, d.nmk, d.nmkk, d.okpo, d.num_nd, d.dat_nd, d.mfo, 
                                   d.acckred, d.accperc, d.mfokred, d.mfoperc, d.refp, d.kprolog,
                                   d.swi_acc, d.swi_bic, d.swo_acc, d.swo_bic,
                                   d.alt_partyb, d.interm_b, d.int_partya, d.int_partyb, d.int_interma, d.int_intermb,
                                   d.int_amount, d.basey, ca.nls_1819, d18.ostc/power(10,t.dig) as ostc, t.dig, t1.dig,
                                   (select name from cc_pawn where pawn = mbk.get_deal_param(d.nd, 'PAWN')) as zal
                               FROM mbk_deal d, accounts d18, tabval t, tabval t1, cc_add ca
                              WHERE d.nd    = :ND
                                AND d18.nls = :NLS and d18.kv = d.a_kv
                                AND d.a_kv  = t.kv  
                                AND d.b_kv  = t1.kv
                                AND d.nd = ca.nd";

                List<TransactionParams> list;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<TransactionParams>(sql, new { nd, nls }).ToList();
                }
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getnbklist")]
        public HttpResponseMessage GetNbkList(string accVostro, string bickA)
        {
            try
            {
                var sql = @"SELECT to_number(a.nls) as nls, a.nms
                              FROM accounts a, BIC_ACC b
                             WHERE UPPER(trim(replace(b.THEIR_ACC, ' ', ''))) = trim(replace(:accVostro, ' ', '')) and b.bic= :bickA and a.acc=b.acc";

                List<Nbk> list;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<Nbk>(sql, new { accVostro, bickA }).ToList();
                }
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getallnbklist")]
        public HttpResponseMessage GetAllNbkList(decimal? kv)
        {
            try
            {
                var sql = @"SELECT a.nls, a.nms, b.bic, b.THEIR_ACC 
                              FROM  bic_acc b, accounts a
                             WHERE a.kv=:kv and a.dazs is null and a.acc=b.acc";

                List<AllNbk> list;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<AllNbk>(sql, new { kv }).ToList();
                }
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/gethistory")]
        public HttpResponseMessage GetHistory(decimal nd)
        {
            try
            {
                var sql = @" SELECT p.fdat, p.npp, Substr(p.txt,1,250) as txt,a.kv, a.nls
                               FROM cc_prol p, accounts a
                              WHERE p.nd=:nd and p.acc=a.acc
                              ORDER BY p.fdat, p.npp";

                List<HistoryList> list;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<HistoryList>(sql, new { nd }).ToList();
                }
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getaccmodel")]
        public HttpResponseMessage GetAccModel(decimal nd)
        {
            try
            {
                var sql = @"select o.ref, 
                                   op.vdat, 
                                   o.tt, 
                                   a.nls, 
                                   op.kv, 
                                   decode(o.dk,0,o.s,0)/100 as db, 
                                   decode(o.dk,1,o.s,0)/100 as kd, 
                                   a.nms 
                              from mbd_k_r m,
                                   opldok o,
                                   oper op,
                                   tabval t,
                                   accounts a
                             where m.nd = :nd
                               and m.ref = o.ref
                               and o.ref = op.ref
                               and op.kv = t.kv
                               and o.acc = a.acc
                             order by o.ref, op.vdat, o.tt";

                List<AccModel> list;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    list = connection.Query<AccModel>(sql, new { nd }).ToList();
                }
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getaccnumber")]
        public HttpResponseMessage GetAccNumber(decimal vidd, decimal rnk, decimal kv, string mask)
        {
            try
            {
                var sql = @"SELECT Substr(Bars.MBK.F_NLS_MB(:vidd,:rnk,0,:kv,:mask),1,30) FROM dual";

                string result;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    result = connection.Query<string>(sql, new { vidd, rnk, kv, mask }).FirstOrDefault();
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getvps")]
        public HttpResponseMessage GetVps(string mfokred, decimal kv)
        {
            try
            {
                var sql = @"select PUL.mvps_fil(:mfokred, :kv) as vps from dual";

                decimal result;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    result = connection.Query<decimal>(sql, new { mfokred, kv }).FirstOrDefault();
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getio")]
        public HttpResponseMessage GetIo(string vidd)
        {
            try
            {
                var sql = @"select nvl(IO,0) from PROC_DR where nbs=:vidd and sour=4";

                decimal result;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    result = connection.Query<decimal>(sql, new { vidd }).FirstOrDefault();
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getints")]
        public HttpResponseMessage GetIntS(decimal amnt, decimal pr, string dateStart, string dateEnd, decimal basey)
        {
            try
            {
                var sql = @"select BARS.CALP_BR( :amnt, :pr, to_date(:dateStart,'dd.mm.yyyy'), to_date(:dateEnd,'dd.mm.yyyy'), :basey ) from DUAL";

                decimal result;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    result = connection.Query<decimal>(sql, new { amnt, pr, dateStart, dateEnd, basey }).FirstOrDefault();
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/mbdk/gettransaction/getswiftref")]
        public HttpResponseMessage GetSwiftRef(decimal newNd)
        {
            try
            {
                var sql = @"SELECT swo_ref FROM cc_add WHERE nd = :newNd and adds = 0";

                string result;
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    result = connection.Query<string>(sql, new { newNd }).FirstOrDefault();
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}