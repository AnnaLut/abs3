using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace Bars.WebServices.Profix
{
    public class ProfixResult
    {
        public int Status { get; set; }
        public string TransferId { get; set; }
        public string TransferState { get; set; }
        public string TransferStateName { get; set; }
        public string TransferNumber { get; set; }
        public string TransferDate { get; set; }
        public string ErrMessage { get; set; }
    }

    /// <summary>
    /// Summary description for ProfixService
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ProfixService : System.Web.Services.WebService
    {

        public ProfixService()
        {
        }

        [WebMethod]
        public ProfixResult CallConfirm(string Method, string SystemId, string TransferId)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            string profixUrl = Bars.Configuration.ConfigurationSettings.AppSettings["Profix.Url"];
            if (string.IsNullOrEmpty(profixUrl))
                throw new ApplicationException("Не задано адресу сервісу Profix (параметр Profix.Url)");

            SWWS swws = new SWWS();
            swws.Url = profixUrl;
            string certName = Bars.Configuration.ConfigurationSettings.AppSettings["Profix.CertSearch"];

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
                throw new System.Exception("Сертифікат для запитів до сервісу Profix не знайдено (пошук по [" + certName + "])");
            }

            swws.ClientCertificates.Add(cert);
            RequestValues args = new RequestValues();
            args.SystemId = SystemId;
            args.Language = "ru";
            args.LoginType = 0;
            args.PointCode = Bars.Configuration.ConfigurationSettings.AppSettings["Profix.PointCode"];
            args.UserLogin = Bars.Configuration.ConfigurationSettings.AppSettings["Profix.UserLogin"];
            args.UserPassword = Bars.Configuration.ConfigurationSettings.AppSettings["Profix.UserPassword"];
            args.Args = new Field[] {
                new Field() {
                    Name = "TransferId", Value = TransferId
                }
            };

            Field[] fields = null;

            var result = new ProfixResult() { Status = 0 };

            try
            {
                if (Method == "SendConfirm")
                    fields = swws.SendConfirm(args);
                else if (Method == "PayoutConfirm")
                    fields = swws.PayoutConfirm(args);
                else if (Method == "ReturnConfirm")
                    fields = swws.ReturnConfirm(args);

                foreach (var field in fields)
                {
                    switch (field.Name)
                    {
                        case "TransferId": result.TransferId = field.Value; break;
                        case "TransferNumber": result.TransferNumber = field.Value; break;
                        case "TransferState": result.TransferState = field.Value; break;
                        case "TransferStateName": result.TransferStateName = field.Value; break;
                        case "TransferDate": result.TransferDate = field.Value; break;
                    }
                }
            }
            catch (System.Web.Services.Protocols.SoapException ex)
            {
                var  xmlDoc = new XmlDocument(); 
                xmlDoc.LoadXml(ex.Detail.InnerXml);
                result.Status = 2;
                result.ErrMessage = xmlDoc.GetElementsByTagName("Message")[0].InnerText;
            }
            catch (System.Exception ex)
            {
                result.Status = 1;
                result.ErrMessage = ex.Message;
            }

            return result;
        }

    }
}