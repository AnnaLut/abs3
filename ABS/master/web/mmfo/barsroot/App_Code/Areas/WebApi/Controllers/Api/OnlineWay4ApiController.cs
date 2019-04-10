using System.Web.Http;
using BarsWeb.Core.Logger;
using System.Net;
using System.Net.Http;
using BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Abstract;
using System.Xml;
using System;
using System.Text;

namespace BarsWeb.Areas.WebApi.OnlineWay4
{
    public class OnlineWay4Controller : ApiController
    {
        readonly IOnlineWay4ApiRepository _repo;
        private readonly IDbLogger _logger;

        public OnlineWay4Controller(IOnlineWay4ApiRepository repo, IDbLogger logger)
        {
            _logger = logger;
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage SendRequest([FromBody] string data)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(data);

                string _type = GetFirstNode(doc, "type").InnerText;
                string _data = GetFirstNode(doc, "data").InnerXml;
                string _header = GetFirstNode(doc, "header", true).InnerXml;

                string res = _repo.SendRequestToWay4(_type, _data, _header);

                return Request.CreateResponse(HttpStatusCode.OK, Convert.ToBase64String(Encoding.UTF8.GetBytes(res)));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        private XmlNode GetFirstNode(XmlDocument doc, string nodeName, bool canBeNull = false)
        {
            XmlNodeList nodes = doc.GetElementsByTagName(nodeName);
            if (null == nodes || nodes.Count <= 0)
            {
                if (canBeNull)
                {
                    XmlDocument nullRes = new XmlDocument();
                    nullRes.LoadXml(string.Format("<{0}></{0}>", nodeName));
                    return nullRes;
                }

                throw new Exception(string.Format("Missing tag \"{0}\"", nodeName));
            }

            return nodes[0];
        }

    }
}
