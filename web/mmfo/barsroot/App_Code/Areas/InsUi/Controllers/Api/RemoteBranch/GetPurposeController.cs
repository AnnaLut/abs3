using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Globalization;

using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class GetPurposeController : ApiController
    {
        public HttpResponseMessage Post(PaymentsParams param)
        {
            PaymentsResponse response = new PaymentsResponse();
            
            OracleConnection con = OraConnector.Handler.UserConnection;
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            string purpose = String.Empty;
            int? errCode;
            String errMessage = String.Empty;
            CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";
            try
            {
                cmd.CommandText = "bars.ins_ewa_mgr.get_purpose";
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, param.contract.salePoint.code, ParameterDirection.Input);
                cmd.Parameters.Add("p_user_name", OracleDbType.Varchar2, param.contract.customFields.Where(x => x.code == "m1").Select(x => x.value).FirstOrDefault(), ParameterDirection.Input);;
                cmd.Parameters.Add("p_mfob", OracleDbType.Varchar2, param.payment.recipientBankMfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_nameb", OracleDbType.Varchar2, param.payment.recipientName, ParameterDirection.Input);
                cmd.Parameters.Add("p_accountb", OracleDbType.Varchar2, param.payment.recipientAccountNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_okpob", OracleDbType.Varchar2, param.payment.recipientCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_ammount", OracleDbType.Decimal, /*(*/param.payment.payment/* + (param.payment.commission > 0 ? param.payment.commission : 0))*/ * 100, ParameterDirection.Input);
                cmd.Parameters.Add("p_commission", OracleDbType.Decimal, param.payment.commission * 100, ParameterDirection.Input);
                cmd.Parameters.Add("p_number", OracleDbType.Varchar2, String.IsNullOrEmpty(param.contract.number) ? param.contract.code : param.contract.number, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_from", OracleDbType.Date, Convert.ToDateTime(param.contract.dateFrom, ci), ParameterDirection.Input);
                cmd.Parameters.Add("p_date_to", OracleDbType.Date, Convert.ToDateTime(param.contract.dateTo, ci), ParameterDirection.Input);
                cmd.Parameters.Add("p_date", OracleDbType.Date, param.payment.date, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_name_last", OracleDbType.Varchar2, (param.contract.tariff.externalId == "ОБ" ? param.contract.insuranceObject.nameLast : param.contract.customer.nameLast), ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_name_first", OracleDbType.Varchar2, (param.contract.tariff.externalId == "ОБ" ? param.contract.insuranceObject.nameFirst : param.contract.customer.nameFirst), ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_name_middle", OracleDbType.Varchar2, (param.contract.tariff.externalId == "ОБ" ? param.contract.insuranceObject.nameMiddle : param.contract.customer.nameMiddle), ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_okpo", OracleDbType.Varchar2, param.contract.customer.code == null ? "0000000000" : param.contract.customer.code, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_series", OracleDbType.Varchar2, param.contract.customer.document.series, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_number", OracleDbType.Varchar2, param.contract.customer.document.number, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_birthdate", OracleDbType.Date, (param.contract.tariff.externalId == "ОБ" ? Convert.ToDateTime(param.contract.insuranceObject.birthDate, ci) : Convert.ToDateTime(param.contract.customer.birthDate, ci)), ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_phone", OracleDbType.Varchar2, param.contract.customer.phone, ParameterDirection.Input);
                cmd.Parameters.Add("p_cust_address", OracleDbType.Varchar2, String.IsNullOrEmpty(param.contract.customer.address) ? (param.contract.insuranceObject.address) : param.contract.customer.address, ParameterDirection.Input);
                cmd.Parameters.Add("p_external_id", OracleDbType.Varchar2, param.contract.tariff.externalId, ParameterDirection.Input);
                cmd.Parameters.Add("p_purpose", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                purpose = cmd.Parameters["p_purpose"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_purpose"].Value.ToString();
                errCode = cmd.Parameters["p_errcode"].Status == OracleParameterStatus.NullFetched ? 0 : Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString());
                errMessage = cmd.Parameters["p_errmessage"].Value.ToString();

                if (errCode != 0)
                {
                    response.success = false;
                    response.message = errMessage;
                    return Request.CreateResponse(HttpStatusCode.OK, response);
                }

            }
            catch (Exception e)
            {
                response.success = false;
                response.message = e.Message;
                return Request.CreateResponse(HttpStatusCode.InternalServerError, response);
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }

            response.success = true;
            response.message = purpose;
            response.externalId = 0;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
