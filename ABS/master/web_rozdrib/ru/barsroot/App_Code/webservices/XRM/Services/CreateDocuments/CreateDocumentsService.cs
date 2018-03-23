using System;
using System.Data;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;
using BarsWeb.Core.Logger;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Services.Protocols;
using Bars.WebServices.XRM.Services.CreateDocuments.Models;
using Bars.WebServices.XRM.Models;
using System.IO;
using System.Xml.Serialization;

/// <summary>
/// XRM boxes integration service
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.CreateDocuments
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-createdocuments.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class CreateDocuments : XrmBaseWebService
    {
        public CreateDocuments()
        {
            moduleName = "XRMIntegrationCreateDocuments";
        }

        public WsHeader WsHeaderValue;

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<OperProcResponse> DocumentsOperation(XRMRequest<OperProcRequest> Request)
        {
            return ExecuteMethod(Request, CreateDocumentsWorker.ProcessOperation);
        }
    }
}
