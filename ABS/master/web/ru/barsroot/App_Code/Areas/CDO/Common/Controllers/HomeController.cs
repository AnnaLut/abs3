using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web.Mvc;
using BarsWeb.Controllers;
using System.Web.Http;

using BarsWeb.Areas.CDO.Common.Repository;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.CDO.Common.Controllers
{
    public class HomeController : ApplicationController
    {
        private IParametersRepository _parametersRepository;
        public HomeController(IParametersRepository parametersRepository)
        {
            _parametersRepository = parametersRepository;
            SslValidation();
        }
        
        public ActionResult Index()
        {
            return View();
        }

        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
        }
        
        public ActionResult Version()
        {
            var version = _parametersRepository.Get("Version");
            if (version == null)
            {
                return Content("0.0.0.0");
            }
            return Content(version.Value);
        }

        // TODO test if it is working
        // TODO delete
        //[System.Web.Mvc.HttpPost]
        //public ActionResult ParseBase64Crt(ParseBase64CrtModel base64crtModel)
        //{
        //    //CX509CertificateRequestPkcs10 request = new CX509CertificateRequestPkcs10();
        //    //request.InitializeDecode(base64crt, EncodingType.XCN_CRYPT_STRING_BASE64_ANY);
        //    //request.CheckSignature();

        //    //Console.WriteLine(((CX500DistinguishedName)request.Subject).Name);
        //    //Console.WriteLine(request.PublicKey.Length);
        //    //Console.WriteLine(request.HashAlgorithm.FriendlyName);
        //    return Json(new {
        //        User = "",
        //        Branch = "",
        //        Organization = "",
        //        SerialNumber = "",
        //        Login = "",
        //        KeyProvider = "",
        //        PublicKey = "",
        //        TemplateName = "",
        //        Subject = "",
        //        PKCS10 = base64crtModel.Base64crt,
        //        Publish = "",
        //        Date = DateTime.Now
        //    }, JsonRequestBehavior.AllowGet);
        //}

    }

    //public class ParseBase64CrtModel {
    //    public string Base64crt { get; set; }
    //}
}