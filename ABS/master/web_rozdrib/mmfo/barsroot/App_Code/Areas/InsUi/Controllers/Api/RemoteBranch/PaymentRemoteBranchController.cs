using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.IO;
using System.Web;
using System.Text;
using System.Xml;
using System.Runtime.Serialization.Json;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class PaymentRemoteBranchController : ApiController
    {
        public HttpResponseMessage Post()
        {
            PaymentsResponse response = new PaymentsResponse() { success = true, message = "Ok" };
            string p_xml = String.Empty;

            using (StreamReader ReqStream = new StreamReader(HttpContext.Current.Request.InputStream))
            {

                using (MemoryStream MemStream = new MemoryStream())
                {

                    XmlDocument xml = new XmlDocument();
                    xml.Load(JsonReaderWriterFactory.CreateJsonReader(Encoding.UTF8.GetBytes(ReqStream.ReadToEnd() as string), new XmlDictionaryReaderQuotas()));
                    xml.Save(MemStream);
                    MemStream.Position = 0;

                    using (StreamReader XmlStrRead = new StreamReader(MemStream))
                    {

                        p_xml = XmlStrRead.ReadToEnd();

                    }


                }
            }


            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "bars.ins_ewa_mgr.pay_isu";
                        cmd.Parameters.Add("p_xml", OracleDbType.XmlType, p_xml, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ref", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        if (cmd.Parameters["p_errcode"].Status == OracleParameterStatus.NullFetched || Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString()) == 0)
                        {
                            response.externalId = cmd.Parameters["p_ref"].Status == OracleParameterStatus.NullFetched ? -1 : Convert.ToInt64(cmd.Parameters["p_ref"].Value.ToString());
                        }
                        else
                        {
                            response.message = cmd.Parameters["p_errmessage"].Value.ToString();
                            response.success = false;
                            response.externalId = -1;
                        }


                    }
                    catch (Exception e)
                    {
                        response.success = false;
                        response.message = e.Message;
                        return Request.CreateResponse(HttpStatusCode.InternalServerError, response);
                    }
                }
            }

            
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        public HttpResponseMessage Get(int docNumber, String account, Decimal ammount)
        {
            PaymentsResponse response = new PaymentsResponse() { success = true, externalId = docNumber};
            String status = String.Empty;
            int? errCode;
            String errMessage = String.Empty;

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.CommandText = "bars.ins_ewa_mgr.get_pay_status";
                        cmd.Parameters.Add("p_ref", OracleDbType.Decimal, docNumber, ParameterDirection.Input);
                        cmd.Parameters.Add("p_account", OracleDbType.Varchar2, account, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ammount", OracleDbType.Decimal, ammount * 100, ParameterDirection.Input);
                        cmd.Parameters.Add("p_status", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        response.message= String.IsNullOrEmpty(cmd.Parameters["p_status"].Value.ToString()) ? String.Empty : cmd.Parameters["p_status"].Value.ToString();
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
                        return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
                    }
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

    }
}