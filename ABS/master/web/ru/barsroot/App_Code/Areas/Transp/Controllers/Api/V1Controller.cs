using Bars.Classes;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web.Http;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using BarsWeb.Areas.Transp.Models.ApiModels;

namespace BarsWeb.Areas.Transp
{
    [AuthorizeApi]
    public class V1Controller : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Direct(string req_type)
        {

            string req_str = Request.Content.ReadAsStringAsync().Result; 
            string xml_str = GetParamsToXml(Request.GetQueryNameValuePairs().ToArray(), Request.Headers.ToArray());
            string resp_str = String.Empty;
            string param_str = String.Empty;
            DbResponce resp_params;


            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "barstrans.transp_utl.resive";
                        cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, req_type, ParameterDirection.Input);
                        cmd.Parameters.Add("p_body", OracleDbType.Clob, req_str, ParameterDirection.InputOutput);
                        cmd.Parameters.Add("p_params", OracleDbType.Clob, xml_str, ParameterDirection.InputOutput);
                        cmd.Parameters.Add("p_resp_params", OracleDbType.Varchar2, 4000, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        using (OracleClob c_resp = (OracleClob)cmd.Parameters["p_body"].Value)
                        {
                            if (!c_resp.IsNull)
                            {
                                resp_str = c_resp.Value;
                            }
                        }

                        using (OracleClob c_param = (OracleClob)cmd.Parameters["p_params"].Value)
                        {
                            if (!c_param.IsNull)
                            {
                                param_str = c_param.Value;
                            }
                        }

                        XmlSerializer serializer = new XmlSerializer(typeof(DbResponce));
                        using (TextReader reader = new StringReader(param_str))
                        {
                            resp_params = (DbResponce)serializer.Deserialize(reader);
                        }


                        if (cmd.Parameters["p_resp_params"].Status == OracleParameterStatus.NullFetched)
                        {

                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);


                            foreach (Headparam param in resp_params.headparams.headparam)
                            {
                                resp.Headers.Add(param.tag, param.value);
                            }

                            resp.Content = new StringContent(resp_str, Encoding.UTF8, resp_params.cont_type);
                            return resp;
                        }
                        else
                        {
                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.NonAuthoritativeInformation);
                            resp.Content = new StringContent(resp_str, Encoding.UTF8, "text/plain");
                            return resp;
                        }
                    }
                    catch (Exception e)
                    {
                        return Request.CreateResponse(HttpStatusCode.NonAuthoritativeInformation, e);
                    }
                }
            }
        }

        [HttpGet]
        public HttpResponseMessage ChkProc(string req_type, Int64? id)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "barstrans.transp_utl.chk_proc";
                        cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, req_type, ParameterDirection.Input);
                        cmd.Parameters.Add("p_id", OracleDbType.Int64, id, ParameterDirection.Input);
                        cmd.Parameters.Add("p_resp", OracleDbType.Int32, ParameterDirection.Output);
                        cmd.Parameters.Add("p_err", OracleDbType.Varchar2, 255, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        if (!String.IsNullOrEmpty(cmd.Parameters["p_err"].Value.ToString()))
                        {

                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                            resp.Content = new StringContent(cmd.Parameters["p_resp"].Value.ToString(), Encoding.UTF8, "text/plain");
                            return resp;
                        }
                        else
                        {
                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.InternalServerError);
                            resp.Content = new StringContent(cmd.Parameters["p_err"].Value.ToString(), Encoding.UTF8, "text/plain");
                            return resp;
                        }


                    }
                    catch (Exception e)
                    {

                        return Request.CreateResponse(HttpStatusCode.InternalServerError, e);

                    }

                }

            }
        }

        [HttpGet]
        public HttpResponseMessage CrtDate(string req_type)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "barstrans.transp_utl.crt_date";
                        cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, req_type, ParameterDirection.Input);
                        cmd.Parameters.Add("p_resp", OracleDbType.Int32, ParameterDirection.Output);
                        cmd.Parameters.Add("p_err", OracleDbType.Varchar2, 255, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        if (!String.IsNullOrEmpty(cmd.Parameters["p_err"].Value.ToString()))
                        {

                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                            resp.Content = new StringContent(cmd.Parameters["p_resp"].Value.ToString(), Encoding.UTF8, "text/plain");
                            return resp;
                        }
                        else
                        {
                            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.InternalServerError);
                            resp.Content = new StringContent(cmd.Parameters["p_err"].Value.ToString(), Encoding.UTF8, "text/plain");
                            return resp;
                        }


                    }
                    catch (Exception e)
                    {

                        return Request.CreateResponse(HttpStatusCode.InternalServerError, e);

                    }

                }

            }
        }



        private string XmlToJson(string xml_str)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xml_str); 
            return JsonConvert.SerializeXmlNode(xmlDoc, Newtonsoft.Json.Formatting.None, false);

           
        }

        private string JsonToXml(string json_str)
        {

            using (MemoryStream MemStream = new MemoryStream())
                {

                    XmlDocument xml = new XmlDocument();
                    xml.Load(JsonReaderWriterFactory.CreateJsonReader(Encoding.UTF8.GetBytes(json_str), new XmlDictionaryReaderQuotas()));
                    xml.Save(MemStream);
                    MemStream.Position = 0;

                    using (StreamReader XmlStrRead = new StreamReader(MemStream))
                    {

                    return XmlStrRead.ReadToEnd();

                    }

                }
        }

        private string GetParamsToXml(KeyValuePair<string, string>[] f_get_vals, KeyValuePair<string, IEnumerable<string>>[] f_head_vals)
        {
            using (MemoryStream stm = new MemoryStream())
            {
                XElement root = new XElement("root");
                XElement getparams = new XElement("getparams");
                foreach (KeyValuePair<string, string> get_val in f_get_vals)
                {
                    XElement tag = new XElement("getparam", new XElement("tag", get_val.Key), new XElement("value", get_val.Value));
                    getparams.Add(tag);
                }
                root.Add(getparams);
                XElement headparams = new XElement("headparams");
                foreach (KeyValuePair<string, IEnumerable<string>> head_val in f_head_vals)
                {
                    XElement tag = new XElement("headparam", new XElement("tag", head_val.Key), new XElement("value", head_val.Value.First()));
                    headparams.Add(tag);
                }
                root.Add(headparams);
                root.Save(stm);
                stm.Position = 0;

                using (StreamReader XmlStrRead = new StreamReader(stm))
                {

                    return XmlStrRead.ReadToEnd();

                }
            }

        }


        public string Base64Encode(byte[] plainText)
        {
            return Convert.ToBase64String(plainText);
        }

        public static byte[] Base64Decode(string base64EncodedData)
        {
            return Convert.FromBase64String(base64EncodedData);
        }


        static byte[] Compress(byte[] data)
        {
            using (MemoryStream compressedStream = new MemoryStream())
            {
                using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Compress))
                {
                    zipStream.Write(data, 0, data.Length);
                    zipStream.Close();
                    return compressedStream.ToArray();
                }
            }
        }

        static byte[] Decompress(byte[] data)
        {
            using (MemoryStream compressedStream = new MemoryStream(data))
            {
                using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Decompress))
                {
                    using (MemoryStream resultStream = new MemoryStream())
                    {
                        zipStream.CopyTo(resultStream);
                        return resultStream.ToArray();
                    }
                }
            }
        }




        /* // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }*/
    }
}