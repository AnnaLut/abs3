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
using Bars.WebServices.XRM.Services.SKRN.Models;
using Bars.WebServices.XRM.Models;
using System.IO;
using System.Xml.Serialization;

/// <summary>
/// XRM boxes integration service
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.SKRN
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-skrn.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class Skrn : XrmBaseWebService
    {
        public Skrn()
        {
            moduleName = "XRMIntegrationSKRN";
        }

        public WsHeader WsHeaderValue;

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<OpenNewBoxResponse> OpenNewSafeDeal(XRMRequest<OpenNewDealRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.OpenNewSafeDeal);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponse CloseSafeDeal(XRMRequest<CloseDealRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.CloseSafeDeal);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement("Response")]
        public XRMResponseDetailed<string> TemplatesCreation(XRMRequest<TemplatesCrtRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.TemplatesCreation, false);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement("Response")]
        public XRMResponseDetailed<PrintDocByRefResponse> PrintDocByRef(XRMRequest<PrintDocByRefRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.PrintDocByRef, false);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement("Response")]
        public XRMResponse SetDocIsSigned(XRMRequest<SetDocIsSignedRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.SetDocIsSigned);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<DocumentsByDealResponse> GetDocsByDeal(XRMRequest<DocsByDealRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.GetDocsByDeal, false);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponse OperDepSkrn(XRMRequest<OperDepSkrnRequest> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.OperDepSkrn);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponse MergeAttorney(XRMRequest<MergeAttorney> Request)
        {
            return ExecuteMethod(Request, SkrnWorker.MergeAttorney);
        }
    }
}
