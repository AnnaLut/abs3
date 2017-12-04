using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Xml.Serialization;
using System.IO;
using System.Text;

using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class CreateDealRemoteBranchController : ApiController
    {
        public HttpResponseMessage Post(CreateDealParams param)
        {
            CreateDealResponse response = new CreateDealResponse();

            if (param.customer.dontHaveCode)
            {
                param.customer.code = "0000000000";
            }

            XmlSerializer ser = new XmlSerializer(typeof(CreateDealParams));
            MemoryStream stream = new MemoryStream();
            ser.Serialize(stream, param);
            stream.Position = 0;
            string pParams = new StreamReader(stream).ReadToEnd();
            
            OracleConnection con = OraConnector.Handler.UserConnection;
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            int? dealNumber;
            int? errCode;
            String errMessage = String.Empty;

            try
            {
                cmd.CommandText = "bars.ins_ewa_mgr.create_deal";
                cmd.Parameters.Add("p_params", OracleDbType.XmlType, pParams, ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_number", OracleDbType.Decimal, ParameterDirection.Output);
                cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, errMessage, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                dealNumber = cmd.Parameters["p_deal_number"].Value.ToString() == "null" ? -1 : Convert.ToInt32(cmd.Parameters["p_deal_number"].Value.ToString());
                errCode = String.IsNullOrEmpty(cmd.Parameters["p_errcode"].Value.ToString()) ? 0 : Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString());
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
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
            
            response.success = true;
            response.message = "Ok";
            response.externalId = dealNumber;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
