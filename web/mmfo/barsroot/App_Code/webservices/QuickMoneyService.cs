using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Net;
using Bars.WebServices.Profix;
using System.Security.Cryptography.X509Certificates;
using System.Xml;
using System.Globalization;
using System.Security.Principal;
using Bars.WebServices.OutsideServices;

namespace Bars.WebServices.QuickMoney
{
    /// <summary>
    /// Сервис АБС для обмена данными с внешним сервисом "Швидка копійка" 
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class QuickMoneyService : System.Web.Services.WebService
    {
        # region Конструктор
        public QuickMoneyService()
        {
        }
        # endregion

        # region Веб-метод
        /// <summary>
        /// Метод вызываемый процедурой pkg_sw_compare.sk_service из DB
        /// </summary>
        [WebMethod]
        public string TransactionShortReport(string Parameters, string ServiceMethod)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | (SecurityProtocolType)768 | (SecurityProtocolType)3072;
            try
            {
                SoapHttpClient client = new SoapHttpClient(TypeClient.ServiceName.QUICK_MONEY);
                var sws = client.InitInst();
                client.SetSettings(sws);
                ProxyModel parameters = client.LoadParams();

                XmlTextReader tr = new XmlTextReader(Parameters, XmlNodeType.Element, null);
                List<Field> list = new List<Field>();
                while (tr.Read())
                {
                    var value = tr.ReadString();
                    list.Add(new Field() { Name = tr.Name, Value = value });
                }

                RequestValues args = new RequestValues();
                args.SystemId = parameters.SystemId;
                args.Language = parameters.Language;
                args.LoginType = parameters.LoginType;
                args.LoginTypeSpecified = true;
                args.PointCode = parameters.PointCode;
                args.UserLogin = parameters.UserLogin;
                args.UserPassword = parameters.UserPassword;
                args.Args = list.ToArray();

                return client.GiveResponse(((SWSvc)sws).ExecOperation((SWSvcMethod)Convert.ToInt32(ServiceMethod), args).FoundRecords);
            }
            catch (System.Exception ex)
            {
                return String.Format("Ошибка соединения с внешним веб-сервисом " + TypeClient.GetStringType(TypeClient.ServiceName.QUICK_MONEY)  + ": " + ex.ToString());
            }
        }
        # endregion
    }
}