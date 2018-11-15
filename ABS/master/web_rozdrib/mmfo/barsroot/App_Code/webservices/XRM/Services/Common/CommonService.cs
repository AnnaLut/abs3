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
using Bars.WebServices.XRM.Services.Common.Models;
using Bars.WebServices.XRM.Models;
using System.IO;
using System.Xml.Serialization;

/// <summary>
/// XRM boxes integration service
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.Common
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-common.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class Common : XrmBaseWebService
    {
        public Common()
        {
            moduleName = "XRMIntegrationCommon";
        }

        public WsHeader WsHeaderValue;

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<SignDocumentsResponse> SignDocuments(XRMRequest<SignDocumentsRequest> Request)
        {
            return ExecuteMethod(Request, CommonWorker.SignDocuments);
        }
    }
}

