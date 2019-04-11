using BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WebApi.OnlineWay4.Models;
using System;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Implementation
{
    public class OnlineWay4ApiRepository : IOnlineWay4ApiRepository
    {
        public OnlineWay4ApiRepository()
        {
        }

        private static string _url = Bars.Configuration.ConfigurationSettings.AppSettings["onlineWay4.url"];
        private static string _prefix = Bars.Configuration.ConfigurationSettings.AppSettings["onlineWay4.prefix"];
        private static string _ns = Bars.Configuration.ConfigurationSettings.AppSettings["onlineWay4.ns"];
        private static string _timeout = Bars.Configuration.ConfigurationSettings.AppSettings["onlineWay4.timeout"];

        public string SendRequestToWay4(string type, string requestData, string header)
        {
            try
            {
                RequestModel req = new RequestModel
                {
                    Data = requestData,
                    Header = header,
                    Method = type,
                    NameSpace = _ns,
                    Prefix = _prefix,
                    Timeout = _timeout,
                    Url = _url
                };
                string a = SOAPHelper.SendSOAPRequest(req);
                return a;
            }
            catch (Exception ex)
            {
                if (ex.Message.ToUpper().Contains("THE OPERATION HAS TIMED OUT"))
                    return (new W4Response
                    {
                        RetCode = -666,
                        RetMsg = ex.Message
                    }).XmlSerialize("response");
                else throw;
            }
        }
    }
}
