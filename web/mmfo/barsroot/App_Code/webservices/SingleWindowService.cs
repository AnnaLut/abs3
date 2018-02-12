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
using System.Security.Principal;
using System.Globalization;
using Bars.WebServices.OutsideServices;
using System.IO;

namespace Bars.WebServices.SingleWindow
{
    /// <summary>
    /// Сервис АБС для обмена данными с внешним сервисом "Единое окно" 
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SingleWindowService : System.Web.Services.WebService
    {
        #region Конструктор
        public SingleWindowService()
        {
        }
        #endregion

        # region Веб-методы
        /// <summary>
        /// Метод вызываемый процедурой pkg_sw_compare.sw_service из DB
        /// </summary>
        [WebMethod]
        public string TransactionDetailReport(string Parameters, string ServiceMethod)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            try
            {
                SoapHttpClient client = new SoapHttpClient(TypeClient.ServiceName.SINGLE_WINDOW);
                var swws = client.InitInst();
                client.SetSettings(swws);
                ProxyModel parameters = client.LoadParams();

                XmlTextReader tr = new XmlTextReader(Parameters, XmlNodeType.Element, null);
                List<Field> list = new List<Field>();
                while(tr.Read())
                {
                    var value = tr.ReadString();
                    list.Add(new Field() { Name = tr.Name, Value = value });
                }

                RequestValues args = new RequestValues();
                args.SystemId = parameters.SystemId;
                args.Language = parameters.Language;
                args.LoginType = parameters.LoginType;
                args.PointCode = parameters.PointCode;
                args.UserLogin = parameters.UserLogin;
                args.UserPassword = parameters.UserPassword;
                args.Args = list.ToArray();

                return client.GiveResponse(((SWWS)swws).ExecOperation((SWWSMethod)Convert.ToInt32(ServiceMethod), args).FoundRecords);
            }
            catch (System.Exception ex)
            {
                return "Ошибка соединения с внешним веб-сервисом " + TypeClient.GetStringType(TypeClient.ServiceName.SINGLE_WINDOW) + ": " +  ex.ToString();
            }
        }
        # endregion
    }
}