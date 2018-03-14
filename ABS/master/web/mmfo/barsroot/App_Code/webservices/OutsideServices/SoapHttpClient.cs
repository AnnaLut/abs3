using Bars.WebServices.Profix;
using Bars.WebServices.QuickMoney;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Services;
using Bars.WebServices.OutsideServices;
using System.Xml;
using Microsoft.CSharp.RuntimeBinder;

namespace Bars.WebServices.OutsideServices
{
    public static class TypeClient
    {
        public enum ServiceName{ SINGLE_WINDOW, QUICK_MONEY }

        public static string GetStringType(ServiceName name) {
            switch (name)
            {
                case ServiceName.QUICK_MONEY:
                    return "QuickMoney";

                case ServiceName.SINGLE_WINDOW:
                    return "SingleWindow";

                default:
                    return "Тип " + name + " - не определен!!!";
            }
        }
    }

    /// <summary>
    /// Создание прокси-класса (клиентского класса) для внешнего сервиса
    /// </summary>
    public class SoapHttpClient
    {
        private TypeClient.ServiceName serviceName;
        private static Dictionary<TypeClient.ServiceName, BaseModel> ServiceSettings = new Dictionary<TypeClient.ServiceName, BaseModel>() {
            { TypeClient.ServiceName.SINGLE_WINDOW, new BaseModel{  LoginType=0, SystemId = "sw"} },
            { TypeClient.ServiceName.QUICK_MONEY, new BaseModel{ LoginType = 1,  SystemId = "st" } }
        };

        public SoapHttpClient(TypeClient.ServiceName serviceName)
        {
            this.serviceName = serviceName;
        }

        public System.Web.Services.Protocols.SoapHttpClientProtocol InitInst()
        {
            switch (serviceName)
            {
                case TypeClient.ServiceName.SINGLE_WINDOW:
                    return new SWWS();

                case TypeClient.ServiceName.QUICK_MONEY:
                    return new SWSvc();
                default:
                    throw new ApplicationException("Ошибка создания клиента для сервиса " + serviceName);
            }
        }

        public void SetSettings(System.Web.Services.Protocols.SoapHttpClientProtocol proxy)
        {
            string sn = TypeClient.GetStringType(serviceName);
            string profixUrl = Bars.Configuration.ConfigurationSettings.AppSettings[sn + ".Url"];
            if (string.IsNullOrEmpty(profixUrl))
                throw new ApplicationException("Не задано адресу сервісу (параметр " + sn + ".Url)");

            proxy.Url = profixUrl;

            string certName = Bars.Configuration.ConfigurationSettings.AppSettings[sn + ".CertSearch"];
            if (!string.IsNullOrEmpty(certName))
                {
                    X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                    store.Open(OpenFlags.ReadOnly);
                    var certCollection = store.Certificates.Find(X509FindType.FindBySubjectName, certName, false);
                    X509Certificate cert = null;
                    try
                    {
                        cert = certCollection[0];
                    }
                    catch (System.Exception ex)
                    {
                        throw new System.Exception("Сертифікат для запитів до сервісу " + serviceName + " не знайдено (пошук по [" + certName + "])");
                    }

                    proxy.ClientCertificates.Add(cert);
                }
        }

        public ProxyModel LoadParams()
        {
            string sn = TypeClient.GetStringType(serviceName);
            return new ProxyModel
            {
                Language = Configuration.ConfigurationSettings.AppSettings[sn + ".Language"],
                PointCode = Configuration.ConfigurationSettings.AppSettings[sn + ".PointCode"],
                UserLogin = Configuration.ConfigurationSettings.AppSettings[sn + ".UserLogin"],
                UserPassword = Configuration.ConfigurationSettings.AppSettings[sn + ".UserPassword"],
                SystemId = ServiceSettings[serviceName].SystemId,
                LoginType = ServiceSettings[serviceName].LoginType
            };
        }

        public string GiveResponse(object[][] response)
        {
            string result = "";
            XmlDocument xmlDoc = new XmlDocument();
            dynamic records = response;

            if (serviceName == TypeClient.ServiceName.SINGLE_WINDOW || 
                (serviceName == TypeClient.ServiceName.QUICK_MONEY && response[0].Length == 1)) //old version for single_window & quick_money.TransactionShortReport
            {

                foreach (var record in records)
                {
                    foreach (var field in record)
                    {
                        xmlDoc.LoadXml(field.Value);
                        XmlNode root = xmlDoc.FirstChild;
                        XmlNodeList list = root["Data"].ChildNodes;
                        foreach (XmlNode node in list)
                            result += node.OuterXml;
                    }
                }
            }
            else
            {
                var recond = response[0][3];
                xmlDoc.LoadXml((recond as QuickMoney.Field).Value);
                XmlNode root = xmlDoc.FirstChild;
                XmlNodeList list = root["NBUSTATREPORT"].ChildNodes;
                foreach (XmlNode node in list)
                    result += node.OuterXml;
            }

            return result;
        }
    }
}