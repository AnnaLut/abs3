using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Runtime.Serialization.Json;
using System.Xml;
using System.Text;
using System.IO;
using System.Web;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class GetPurposeController : ApiController
    {
        public HttpResponseMessage Post()
        {
            PaymentsResponse response = new PaymentsResponse() { success = true, externalId = 0};
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
                            cmd.CommandText = "bars.ins_ewa_mgr.get_purpose";
                            cmd.Parameters.Add("p_clob", OracleDbType.XmlType, p_xml, ParameterDirection.Input);
                            cmd.Parameters.Add("p_purpose", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, ParameterDirection.Output);
                            cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                            cmd.ExecuteNonQuery();


                        if (cmd.Parameters["p_errcode"].Status == OracleParameterStatus.NullFetched || Convert.ToInt32(cmd.Parameters["p_errcode"].Value.ToString()) == 0)
                        {
                            response.message = cmd.Parameters["p_purpose"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_purpose"].Value.ToString();
                        }
                        else
                        {
                            response.message = cmd.Parameters["p_errmessage"].Value.ToString();
                            response.success = false;
                        }


                        }
                        catch (Exception e)
                        {


                            response.success = false;
                            response.message = e.Message;
                            return Request.CreateResponse(HttpStatusCode.InternalServerError, response);


                        }

                     return Request.CreateResponse(HttpStatusCode.OK, response);

                    }
                }
           
        }
    }
}
