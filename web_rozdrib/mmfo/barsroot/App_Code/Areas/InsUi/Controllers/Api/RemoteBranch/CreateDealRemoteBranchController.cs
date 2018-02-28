using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.IO;
using System.Text;
using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Xml;
using System.Runtime.Serialization.Json;
using System.Web;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class CreateDealRemoteBranchController : ApiController
    {
        public HttpResponseMessage Post()
        {
            CreateDealResponse response = new CreateDealResponse() { success = true, message = "Ok" };

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
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.CommandText = "bars.ins_ewa_mgr.create_deal";
                        cmd.Parameters.Add("p_params", OracleDbType.XmlType, p_xml, ParameterDirection.Input);
                        cmd.Parameters.Add("p_deal_number", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        if (cmd.Parameters["p_errcode"].Status == OracleParameterStatus.NullFetched || Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString()) == 0)
                        {
                            response.externalId = cmd.Parameters["p_deal_number"].Value.ToString() == "null" ? -1 : Convert.ToInt32(cmd.Parameters["p_deal_number"].Value.ToString());
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
                        return Request.CreateResponse(HttpStatusCode.OK, response);
                    }
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
