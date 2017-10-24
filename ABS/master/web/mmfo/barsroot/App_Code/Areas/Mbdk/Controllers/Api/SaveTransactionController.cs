using System;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Models;
using Dapper;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class SaveTransactionController : ApiController
    {
        [HttpPost]
        [POST("api/mbdk/savetransaction/saveRollOver")]
        public HttpResponseMessage SaveRollOver(SaveParams param)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("CC_ID_NEW", param.CC_ID_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("ND_", param.ND, DbType.Int64, ParameterDirection.Input);
                    p.Add("ND_NEW", dbType: DbType.Int64, direction: ParameterDirection.Output);
                    p.Add("ACC_NEW", dbType: DbType.Int64, direction: ParameterDirection.Output);
                    p.Add("nID_", param.nID, DbType.Int32, ParameterDirection.Input);
                    p.Add("nKV_", param.nKV, DbType.Int32, ParameterDirection.Input);
                    p.Add("NLS_OLD", param.NLS_OLD, DbType.String, ParameterDirection.Input);
                    p.Add("NLS_NEW", param.NLS_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("NLS8_NEW", param.NLS8_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("nS_OLD", param.nS_OLD, DbType.Decimal, ParameterDirection.Input);
                    p.Add("nS_NEW", param.nS_NEW, DbType.Decimal, ParameterDirection.Input);
                    p.Add("nPR_OLD", param.nPR_OLD, DbType.Decimal, ParameterDirection.Input);
                    p.Add("nPR_NEW", param.nPR_NEW, DbType.Decimal, ParameterDirection.Input);
                    p.Add("DATK_OLD", param.DATK_OLD, DbType.Date, ParameterDirection.Input);
                    p.Add("DATK_NEW", param.DATK_NEW, DbType.Date, ParameterDirection.Input);
                    p.Add("DATN_OLD", param.DATN_OLD, DbType.Date, ParameterDirection.Input);
                    p.Add("DATN_NEW", param.DATN_NEW, DbType.Date, ParameterDirection.Input);
                    p.Add("NLSB_NEW", param.NLSB_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("MFOB_NEW", param.MFOB_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("NLSNB_NEW", param.NLSNB_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("MFONB_NEW", param.MFONB_NEW, DbType.String, ParameterDirection.Input);
                    p.Add("REFP_NEW", param.REFP_NEW, DbType.Decimal, ParameterDirection.Input);
                    p.Add("BICA_", param.BICA, DbType.String, ParameterDirection.Input);
                    p.Add("SSLA_", param.SSLA, DbType.String, ParameterDirection.Input);
                    p.Add("BICB_", param.BICB, DbType.String, ParameterDirection.Input);
                    p.Add("SSLB_", param.SSLB, DbType.String, ParameterDirection.Input);
                    p.Add("AltB_", param.AltB, DbType.String, ParameterDirection.Input);
                    p.Add("IntermA_", param.IntermA, DbType.String, ParameterDirection.Input);
                    p.Add("IntermB_", param.IntermB, DbType.String, ParameterDirection.Input);
                    p.Add("IntPartyA_", param.IntPartyA, DbType.String, ParameterDirection.Input);
                    p.Add("IntPartyB_", param.IntPartyB, DbType.String, ParameterDirection.Input);
                    p.Add("IntIntermA_", param.IntIntermA, DbType.String, ParameterDirection.Input);
                    p.Add("IntIntermB_", param.IntIntermB, DbType.String, ParameterDirection.Input);
                    p.Add("IntAmount_", param.IntAmount, DbType.Decimal, ParameterDirection.Input);

                    connection.Execute("BARS.MBK.RO_deal", p, commandType: CommandType.StoredProcedure);
                    var nd = p.Get<Int64?>("ND_NEW");
                    var acc = p.Get<Int64?>("ACC_NEW");
                    var resultObj = new { nd, acc };
                    return Request.CreateResponse(HttpStatusCode.OK, resultObj);
                }         
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        
        [HttpPost]
        [POST("api/mbdk/savetransaction/setdealparam")]
        public HttpResponseMessage SetDealParam(decimal nd, string tag, string val)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_nd", nd, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_tag", tag, DbType.String, ParameterDirection.Input);
                    p.Add("p_val", val, DbType.String, ParameterDirection.Input);

                    connection.Execute("BARS.MBK.set_deal_param", p, commandType: CommandType.StoredProcedure);

                    return Request.CreateResponse(HttpStatusCode.OK);
                }
            }
            finally
            { 

            }
        }

        [HttpGet]
        public HttpResponseMessage SaveRollOver1(string newReff, string sw_options)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_dealRef", Convert.ToDecimal(newReff), DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_msgFlag", String.Empty, DbType.String, ParameterDirection.Input);
                    p.Add("p_msgOption", sw_options, DbType.String, ParameterDirection.Input);

                    connection.Execute("BARS.SWIFT.Gen_MT320_Message", p, commandType: CommandType.StoredProcedure);

                    return Request.CreateResponse(HttpStatusCode.OK, "OK");
                }
            }
            catch (Exception ex) { return Request.CreateResponse(HttpStatusCode.OK,"Error"); }
            finally
            {

            }
        }
    }
}
