using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Models;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Implementation;
using Dapper;
using Oracle.DataAccess.Client;
using Newtonsoft.Json.Linq;
using System.Data;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class GetDataController : ApiController
    {
        private readonly IDealRepository _deal;

        public GetDataController(IDealRepository deal)
        {
            _deal = deal;
        }

        [HttpGet]
        public HttpResponseMessage GetInitialTransferList()
        {
            try
            {
                var sql = @"select CODE, TXT from CP_OB_INITIATOR where f_ourmfo='300465'";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    object list = connection.Query(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetAgreements()
        {
            try
            {
                var sql = @"select name, vidd from v_mbdk_product order by vidd";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCurrencyList()
        {
            try
            {
                var sql = @"select trim(lcv) lcv, kv from tabval";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBasesData()
        {
            try
            {
                var sql = @"select BASEY, NAME  from  basey where basey <4 order by basey";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetScoreList(string kvStr)
        {
            decimal KV;
            if (!decimal.TryParse(kvStr, out KV))
            {
                throw new Exception("Невірний код валюти!");
            }
            try
            {
                var sql = @"SELECT  NLS, SUBSTR(NMS,1,38)||' ('||kv||')'  NMS 
                            FROM ACCOUNTS 
                            WHERE KV=:KV
                            AND DAZS IS NULL AND ACC IN (SELECT ACC FROM BIC_ACC) 
                            ORDER BY NLS";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query(sql, new { KV }).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);

                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        //Траса платежу вхідного (57-BIC, Рах)
        [HttpGet]
        public HttpResponseMessage GetRoadInfo(decimal nls, decimal kv)
        {
            try
            {
                var sql = @"SELECT a.nms, b.bic, b.THEIR_ACC ACC
                            FROM bic_acc b, accounts a
                            WHERE a.nls=:nls AND a.kv=:kv
                            AND a.dazs is null AND a.acc=b.acc";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var result = connection.Query<RoadUser>(sql, new { nls, kv }).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, result);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetContractorParams(decimal nVidd, decimal rnkB, decimal kv)
        {
            try
            {
                var sql = @"SELECT nls, decode((select TIPD from CC_VIDD where VIDD = :nVidd),1,null,nls) as nlsn, swo_bic, swo_acc, swo_alt, interm_b, field_58d   
                                FROM cc_swtrace
                                WHERE rnk = :rnkB
                                AND kv  = :kv";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var result = connection.Query<ContractorParams>(sql, new { nVidd, rnkB, kv }).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, result);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        //Траса платежу вхідного (57-BIC, Рах)
        [HttpGet]
        public HttpResponseMessage GetBase(decimal basey)
        {
            try
            {
                var sql = @"select name from basey where basey = :basey";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    object data = connection.Query(sql, new { basey }).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage CheckTicketNumber(string ticketNumber)
        {
            try
            {
                var sql = @"select count(*) from cc_deal where cc_id =:ticketNumber";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var data = connection.Query<int>(sql, new { ticketNumber }).SingleOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        //Траса платежу вхідного (57-BIC, Рах)
        [HttpGet]
        public HttpResponseMessage GetNms(decimal nls, decimal kv)
        {
            try
            {
                var sqlNms = @"select nms  from accounts where nls = :nls and kv = :kv";

                using (var connection = OraConnector.Handler.UserConnection)
                {

                    object data = connection.Query(sqlNms, new { nls, kv }).SingleOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, data);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }


        [HttpPost]
        public HttpResponseMessage GetScoreNms(ScoreNms model)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _deal.ScoresNms(model));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage CalcSumm(SummInfo model)
        {
            try
            {
                var sum = _deal.DealSum(model);
                if (sum < 0)
                    return Request.CreateResponse(HttpStatusCode.OK, "Некоректні дані");
                return Request.CreateResponse(HttpStatusCode.OK, sum);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCurrency()
        {
            return Request.CreateResponse(HttpStatusCode.OK, _deal.GetCurrency());
        }

        [HttpGet]
        public HttpResponseMessage GetBankDate()
        {
            var date = new DateOperation();
            return Request.CreateResponse(HttpStatusCode.OK, date.GetCurrentDate());
        }

        [HttpGet]
        public HttpResponseMessage GetProviding()
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query("select pawn, pawn_23, name, S031_279, GRP23, D_CLOSE  from cc_pawn").ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage GetProvidingScore(ProvidingScore model)
        {
            try
            {
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    OracleCommand command = new OracleCommand("mbk.get_pawn_account_number", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    
                    OracleParameter pawnAccountNumberParameter = new OracleParameter("p_pawn_account_number", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue);
                    command.Parameters.Add(pawnAccountNumberParameter);
                    command.Parameters.Add("p_main_account_number", model.mainDealAccount);
                    command.Parameters.Add("p_pawn_kind_id", model.pawn);
                    command.Parameters.Add("p_deal_kind_id", model.nTip);
                    command.Parameters.Add("p_customer_id", model.rnk);
                    command.Parameters.Add("p_currency_id", model.kv);
                    command.ExecuteNonQuery();

                    OracleString pawnAccountNumberValue = (OracleString)pawnAccountNumberParameter.Value;
                    string score = pawnAccountNumberValue == null ? "" : pawnAccountNumberValue.Value;
                    
                    return Request.CreateResponse(HttpStatusCode.OK, new { score });
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetFreeAccountsInBriefcase(decimal nVidd, decimal nKv, decimal RNKB, decimal nSUM)
        {
            var sql = @"SELECT a.nls as mainAccount, a.mdate as completionDate, n.nls as accrualsAccount, n.mdate as accrualsCompletionDate,
                        a.OSTC/power(10,t.dig) as mainAccountBalance, n.OSTC/power(10,t.dig) as accrualsAccountBalance
                        FROM accounts a, int_accn i, accounts n, tabval t, mbd_k m 
                        WHERE a.nbs=:nVidd AND a.kv=:nKv AND a.rnk=:RNKB 
                        AND a.acc=i.acc AND i.acra=n.acc
                        AND a.ostc=(:nSUM)*power(10,t.dig)
                        AND a.ostb=(:nSUM)*power(10,t.dig) AND a.ostf=0
                        AND n.ostc=0 AND n.ostb=0 AND n.ostf=0
                        AND (a.mdate<bankdate_g OR a.mdate IS NULL) AND a.dazs is null
                        AND (n.mdate<bankdate_g OR n.mdate IS NULL) AND n.dazs is null
                        AND a.acc=m.acc
                        AND a.kv=t.kv
                        ORDER BY substr(a.nls,12,2)";
            try
            {

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var items = connection.Query(sql, new { nVidd, nKv, RNKB, nSUM });
                    return Request.CreateResponse(HttpStatusCode.OK, items);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetFreeAccountsOutsideBriefcase(decimal nVidd, decimal nKv, decimal RNKB)
        {
            var sql = @"SELECT a.nls as mainAccount, a.mdate as completionDate, n.nls as accrualsAccount, n.mdate as accrualsCompletionDate,
                        a.OSTC/power(10,t.dig) as mainAccountBalance, n.OSTC/power(10,t.dig) as accrualsAccountBalance
                        FROM accounts a, int_accn i, accounts n, tabval t 
                        WHERE a.nbs=:nVidd AND a.kv=:nKv AND a.rnk=:RNKB 
                        AND a.acc not in (select ACC from MBD_K)
                        AND a.acc=i.acc AND i.acra=n.acc
                        AND a.dazs is null
                        AND n.dazs is null
                        AND a.kv=t.kv
                        ORDER BY substr(a.nls,12,2)";
            try
            {

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var items = connection.Query(sql, new { nVidd, nKv, RNKB });
                    return Request.CreateResponse(HttpStatusCode.OK, items);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetFreeAccountsWithoutBalance(decimal nVidd, decimal nKv, decimal RNKB)
        {
            var sql = @"SELECT a.nls as mainAccount, a.mdate as completionDate, n.nls as accrualsAccount, n.mdate as accrualsCompletionDate
                        FROM accounts a, int_accn i, accounts n, tabval t 
                        WHERE a.nbs=:nVidd 
                        AND a.kv=:nKv 
                        AND a.rnk=:RNKB 
                        AND a.acc=i.acc AND i.acra=n.acc
                        AND a.ostc=0 AND a.ostb=0 AND a.ostf=0
                        AND n.ostc=0 AND n.ostb=0 AND n.ostf=0
                        AND (a.mdate<bankdate_g OR a.mdate IS NULL) AND a.dazs is null
                        AND (n.mdate<bankdate_g OR n.mdate IS NULL) AND n.dazs is null
                        AND a.kv=t.kv AND (a.dapp is null or a.dapp < bankdate-10)
                        AND ( ( nvl(f_proc_dr(:RNKB,4,1,'MKD',:nVidd,:nKv),0) > 0 AND i.acrb=f_proc_dr(:RNKB,4,1,'MKD',:nVidd,:nKv) ) 
                        OR ( nvl(f_proc_dr(:RNKB,4,1,'MKD',:nVidd,:nKv),0) <= 0 )) 
                        ORDER BY substr(a.nls,12,2)";
            try
            {

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var items = connection.Query(sql, new { nVidd, nKv, RNKB });
                    return Request.CreateResponse(HttpStatusCode.OK, items);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SaveRoadParams([FromBody] JObject requestData)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var rnk = requestData["rnk"].ToObject<string>();
                    var currencyCode = requestData["currencyCode"].ToObject<string>();
                    var partnerBick = requestData["partnerBick"].ToObject<string>();
                    var partnerAccount = requestData["partnerAccount"].ToObject<string>();
                    var altRoad = requestData["altRoad"].ToObject<string>();
                    var sIntermB = requestData["sIntermB"].ToObject<string>();
                    var s58D = requestData["s58D"].ToObject<string>();
                    var partherAccNumber = requestData["partherAccNumber"].ToObject<string>();

                    
                    OracleCommand command = new OracleCommand("mbk.save_partner_trace", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_custCode", OracleDbType.Int64, rnk, ParameterDirection.Input);
                    command.Parameters.Add("p_currCode", OracleDbType.Int64, currencyCode, ParameterDirection.Input);
                    command.Parameters.Add("p_swoBic", OracleDbType.Varchar2, partnerBick, ParameterDirection.Input);
                    command.Parameters.Add("p_swoAcc", OracleDbType.Varchar2, partnerAccount, ParameterDirection.Input);
                    command.Parameters.Add("p_swoAlt", OracleDbType.Varchar2, altRoad, ParameterDirection.Input);
                    command.Parameters.Add("p_intermb", OracleDbType.Varchar2, sIntermB, ParameterDirection.Input);
                    command.Parameters.Add("p_field58d", OracleDbType.Varchar2, s58D, ParameterDirection.Input);
                    command.Parameters.Add("p_nls", OracleDbType.Varchar2, partherAccNumber, ParameterDirection.Input);


                    command.ExecuteNonQuery();
                    return Request.CreateResponse(HttpStatusCode.OK,1);

                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDealType(decimal nVidd)
        {
            var sql = @"select TIPD from CC_VIDD where VIDD = :nVidd";
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    object type = connection.Query(sql, new { nVidd}).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, type);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}