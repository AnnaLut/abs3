using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Collections.Generic;
using BarsWeb.Areas.Transp.Infrastructure.DI.Abstract;
using System.Xml;
using System.Runtime.Serialization.Json;
using System.IO.Compression;
using Newtonsoft.Json;
using BarsWeb.Areas.Transp.Models.ApiModels;
using System.Web;
using System.Xml.Linq;

namespace BarsWeb.Areas.Transp
{
    [AuthorizeApi]
    public class V1Controller : ApiController
    {
        
        private ITranspRepository _repo;
        public V1Controller(ITranspRepository repo)
        {
            _repo = repo;
        }
        [HttpPost]
        public HttpResponseMessage Post(string req_type, string req_act)
        {
            string ReqStr = String.Empty;

            string RespBody = String.Empty;

            string ReqId = String.Empty;

            string UserName = HttpContext.Current.User.Identity.Name;
                        
            byte[] ReqBody = Request.Content.ReadAsByteArrayAsync().Result;

            InputTypes reqType = null;
            try
            {
                reqType = _repo.GetReqType(req_type);
            }
            catch (Exception e)
            {
                string ErrGuid = LogErr2Db(null, "SELECT_FROM_INPUT_TYPES", e.Message, e.StackTrace);

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ErrGuid.ToUpper(), e);

            }

            try
            {
                ReqStr = ConvReqBody(reqType, ReqBody);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
            }
                 
                ReqId = _repo.InsertReq(req_type, "POST", req_act, UserName, CrtGetParamXml(Request.GetQueryNameValuePairs().ToArray()), ReqStr);
                       

            if (reqType.store_head == 1)
            {

                    _repo.InsertReqParams(ReqId, "HEADER", CrtHeadParamXml(Request.Headers.ToArray()));
        
            }
            
                _repo.ProcessRequest(ReqId);

            if (reqType.sess_type == "ASYNCH")
            {                
                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                resp.Content = new StringContent(CrtRespXml(ReqId, null), Encoding.UTF8, "text/xml");
                return resp;
            }
            else
            {
                try
                {
                    RespBody = ConvRspBody(reqType, ReqId, UserName);
                }
                catch (Exception e)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
                }
            

                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);

                if (reqType.add_head == 1)
                {
                    foreach (KeyValuePair<string, string> param in _repo.GetRespParams(ReqId))
                    {
                        resp.Headers.Add(param.Key, param.Value);
                    }
                }                

                resp.Content = new StringContent(RespBody, Encoding.UTF8, String.IsNullOrEmpty(reqType.cont_type) ? "text/plain" : reqType.cont_type);
                return resp;

            }                

        }

        [HttpPut]
        public HttpResponseMessage Put(string req_type, string req_act)
        {
            string ReqStr = String.Empty;

            string RespBody = String.Empty;

            string ReqId = String.Empty;

            string UserName = HttpContext.Current.User.Identity.Name;

            byte[] ReqBody = Request.Content.ReadAsByteArrayAsync().Result;

            InputTypes reqType = null;
            try
            {
                reqType = _repo.GetReqType(req_type);
            }
            catch (Exception e)
            {
                string ErrGuid = LogErr2Db(null, "SELECT_FROM_INPUT_TYPES", e.Message, e.StackTrace);

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ErrGuid.ToUpper(), e);

            }

            try
            {
                ReqStr = ConvReqBody(reqType, ReqBody);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
            }

            ReqId = _repo.InsertReq(req_type, "PUT", req_act, UserName, CrtGetParamXml(Request.GetQueryNameValuePairs().ToArray()), ReqStr);


            if (reqType.store_head == 1)
            {

                _repo.InsertReqParams(ReqId, "HEADER", CrtHeadParamXml(Request.Headers.ToArray()));

            }

            _repo.ProcessRequest(ReqId);

            if (reqType.sess_type == "ASYNCH")
            {
                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                resp.Content = new StringContent(CrtRespXml(ReqId, null), Encoding.UTF8, "text/xml");
                return resp;
            }
            else
            {
                try
                {
                    RespBody = ConvRspBody(reqType, ReqId, UserName);
                }
                catch (Exception e)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
                }


                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);

                if (reqType.add_head == 1)
                {
                    foreach (KeyValuePair<string, string> param in _repo.GetRespParams(ReqId))
                    {
                        resp.Headers.Add(param.Key, param.Value);
                    }
                }

                resp.Content = new StringContent(RespBody, Encoding.UTF8, String.IsNullOrEmpty(reqType.cont_type) ? "text/plain" : reqType.cont_type);
                return resp;

            }

        }


        [HttpGet]
        public HttpResponseMessage Get(string req_type, string req_act)
        {
            string RespBody = String.Empty;

            string ReqId = String.Empty;

            string UserName = HttpContext.Current.User.Identity.Name;

            InputTypes reqType = null;
            try
            {
                reqType = _repo.GetReqType(req_type);
            }
            catch (Exception e)
            {
                string ErrGuid = System.Guid.NewGuid().ToString();

                _repo.InputLoger(ErrGuid.ToUpper(), "SELECT_FROM_INPUT_TYPES", "ERROR", e.Message, e.StackTrace);

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ErrGuid.ToUpper(), e);

            }

            if (req_act == "GETREQSTATUS")
            {

                foreach (KeyValuePair<string, string> param in Request.GetQueryNameValuePairs().ToArray())
                {
                    if (param.Key == "REQID")
                    {
                        ReqId = param.Value;
                    }

                }

                if (!String.IsNullOrEmpty(ReqId))
                {
                    RespBody = _repo.GetReqStatus(ReqId, UserName);

                    HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                    resp.Content = new StringContent(CrtRespXml(ReqId, RespBody), Encoding.UTF8, "text/xml");
                    return resp;

                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Parameter REQID not found");
                }
                
            }
            else if (req_act == "GETRESP")
            {

                foreach (KeyValuePair<string, string> param in Request.GetQueryNameValuePairs().ToArray())
                {
                    if (param.Key == "REQID")
                    {
                        ReqId = param.Value;
                    }

                }

                if (!String.IsNullOrEmpty(ReqId))
                {
                    RespBody = ConvRspBody(reqType, ReqId, UserName);
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Parameter REQID not found");
                }
                 

                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);

                if (reqType.add_head == 1)
                {
                    foreach (KeyValuePair<string, string> param in _repo.GetRespParams(ReqId))
                    {
                        resp.Headers.Add(param.Key, param.Value);
                    }
                }

                resp.Content = new StringContent(RespBody, Encoding.UTF8, String.IsNullOrEmpty(reqType.cont_type) ? "text/plain" : reqType.cont_type);
                return resp;

            }
            else
            {
                ReqId = _repo.InsertReq(req_type, "GET", req_act, UserName, CrtGetParamXml(Request.GetQueryNameValuePairs().ToArray()));

                if (reqType.store_head == 1)
                {
                    _repo.InsertReqParams(ReqId, "HEADER", CrtHeadParamXml(Request.Headers.ToArray()));
                }

                _repo.ProcessRequest(ReqId);

                if (reqType.sess_type == "ASYNCH")
                {
                    HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);
                    resp.Content = new StringContent(CrtRespXml(ReqId, null), Encoding.UTF8, "text/xml");
                    return resp;
                }
                else
                {
                    RespBody = ConvRspBody(reqType, ReqId, UserName);

                    HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.OK);

                    if (reqType.add_head == 1)
                    {

                        foreach (KeyValuePair<string, string> param in _repo.GetRespParams(ReqId))
                        {
                            resp.Headers.Add(param.Key, param.Value);
                        }
                    }

                    resp.Content = new StringContent(RespBody, Encoding.UTF8, String.IsNullOrEmpty(reqType.cont_type) ? "text/plain" : reqType.cont_type);
                    return resp;

                }

            }

        }

        private string ConvReqBody(InputTypes ReqType, byte[] ReqBody)
        {
            String ReqStr = String.Empty;

            if (ReqType.json2xml == 1)
            {
                if (ReqType.input_decompress == 1)
                {
                    try
                    {
                        ReqBody = Decompress(ReqBody);
                    }
                    catch (Exception e)
                    {
                        string ErrGuid = LogErr2Db(null, "DECOMPRESS_REQUEST_BODY", e.Message, e.StackTrace);

                        throw new Exception("DECOMPRESS_REQUEST_BODY" + ErrGuid, e);
                    }
                }

                if (ReqType.input_base_64 == 1)
                {
                    try
                    {
                        ReqBody = Convert.FromBase64String(Encoding.UTF8.GetString(ReqBody));
                    }
                    catch (Exception e)
                    {
                        string ErrGuid = LogErr2Db(null, "CONVERT_FROM_BASE64_REQUEST_BODY", e.Message, e.StackTrace);

                        throw new Exception("CONVERT_FROM_BASE64_REQUEST_BODY" + ErrGuid, e);
                    }
                }

                try
                {
                    ReqStr = Json2Xml(ReqBody);
                }
                catch (Exception e)
                {
                    string ErrGuid = LogErr2Db(null, "CONVERT_JSON_TO_XML", e.Message, e.StackTrace);

                    throw new Exception("CONVERT_JSON_TO_XML" + ErrGuid, e);
                }
            }
            else if (ReqType.input_data_type == "BLOB")
            {
                try
                {
                    ReqStr = Convert.ToBase64String(ReqBody);
                }
                catch (Exception e)
                {
                    string ErrGuid = LogErr2Db(null, "CONVERT_REQ_BODY_TO_BASE64", e.Message, e.StackTrace);

                    throw new Exception("CONVERT_REQ_BODY_TO_BASE64" + ErrGuid, e);
                }
            }
            else
            {
                ReqStr = Encoding.UTF8.GetString(ReqBody);
            }

            return ReqStr;

        }

        private string ConvRspBody(InputTypes ReqType, string ReqId, string UserName)
        {
            string RespBody = _repo.GetRespData(ReqId, UserName);

            if (ReqType.xml2json == 1)
            {
                try
                {
                    RespBody = XmlToJson(RespBody);
                }
                catch (Exception e)
                {
                    _repo.InputLoger(ReqId.ToUpper(), "CONVERT_RESP_XML_TO_JSON", "ERROR", e.Message, e.StackTrace);

                    throw new Exception("CONVERT_RESP_XML_TO_JSON" + ReqId, e);
                }


                if (ReqType.output_compress == 1)
                {
                    try
                    {
                        RespBody = Convert.ToBase64String(Compress(Encoding.UTF8.GetBytes(RespBody)));
                    }
                    catch (Exception e)
                    {
                        _repo.InputLoger(ReqId.ToUpper(), "COMPRESS_RESP", "ERROR", e.Message, e.StackTrace);

                        throw new Exception("COMPRESS_RESP" + ReqId, e);
                    }

                }
            }

            return RespBody;
        }

        private string LogErr2Db(string Guid, string Err_coment, string ErrMes, string ErrTrace)
        {
            string ErrGuid = String.Empty;
            
            if (String.IsNullOrEmpty(Guid))
            ErrGuid = System.Guid.NewGuid().ToString();
            else
            ErrGuid = Guid;
            
            

            _repo.InputLoger(ErrGuid.ToUpper(), Err_coment, "ERROR", ErrMes, ErrTrace);

            return ErrGuid;
        }

        private string Json2Xml(byte[] ReqBody)
        {

            using(StringWriter XmlStrWriter = new StringWriter())
            using (XmlTextWriter XmlWriter = new XmlTextWriter(XmlStrWriter))
            {

                XmlDocument xml = new XmlDocument();
                xml.Load(JsonReaderWriterFactory.CreateJsonReader(ReqBody, new XmlDictionaryReaderQuotas()));
                xml.Save(XmlWriter);
                return XmlStrWriter.ToString();
            }

        }

        private byte[] Decompress(byte[] ReqBody)
        {
            using (MemoryStream compressedStream = new MemoryStream(Convert.FromBase64String(Encoding.UTF8.GetString(ReqBody))))
            using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Decompress))
            using (MemoryStream resultStream = new MemoryStream())
            {

                zipStream.CopyTo(resultStream);
                return resultStream.ToArray();

            }  

        }

        private byte[] Compress(byte[] data)
        {
            using (MemoryStream compressedStream = new MemoryStream())
            using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Compress))
            {
                zipStream.Write(data, 0, data.Length);
                zipStream.Close();
                return compressedStream.ToArray();
            }
        }

        private string XmlToJson(string xml_str)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xml_str);
            return JsonConvert.SerializeXmlNode(xmlDoc, Newtonsoft.Json.Formatting.None, true);
        }

        private string CrtRespXml(string req_id, string status)
        {
            using (StringWriter XmlStrWriter = new StringWriter())
            using (XmlTextWriter XmlWriter = new XmlTextWriter(XmlStrWriter))
            {
                XElement root = new XElement("root");
                XElement ReqId = new XElement("req_id", req_id);
                root.Add(ReqId);
                XElement State = new XElement("status", status);
                root.Add(State);
                root.Save(XmlWriter);
                return XmlStrWriter.ToString();
            }

        }

        private string CrtGetParamXml(KeyValuePair<string, string>[] ReqParams)
        {

                using (StringWriter XmlStrWriter = new StringWriter())
                using (XmlTextWriter XmlWriter = new XmlTextWriter(XmlStrWriter))
                {
                    XElement root = new XElement("root");

                    foreach (KeyValuePair<string, string> get_val in ReqParams)
                    {
                    XElement tag = new XElement("param", new XElement("tag", get_val.Key), new XElement("value", get_val.Value));
                    root.Add(tag);
                }
                    root.Save(XmlWriter);
                    return XmlStrWriter.ToString();
                }

            
        }

        private string CrtHeadParamXml(KeyValuePair<string, IEnumerable<string>>[] ReqParams)
        {

            using (StringWriter XmlStrWriter = new StringWriter())
            using (XmlTextWriter XmlWriter = new XmlTextWriter(XmlStrWriter))
            {
                XElement root = new XElement("root");

                foreach (KeyValuePair<string, IEnumerable<string>> head_val in ReqParams)
                {
                    XElement tag = new XElement("param", new XElement("tag", head_val.Key), new XElement("value", head_val.Value.First()));
                    root.Add(tag);
                }
                root.Save(XmlWriter);
                return XmlStrWriter.ToString();
            }


        }

    }
}