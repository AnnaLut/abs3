using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web.Mvc;
using BarsWeb.Controllers;
using clientregister;

namespace BarsWeb.Areas.CorpLight.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class UsersController : ApplicationController
    {
        public UsersController()
        {
            SslValidation();
        }

        public ActionResult Index()
        {
            return View();
        }

        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback = 
                delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) 
                {
                    return true;
                };
        }
        private List<defaultWebService.ConfirmPhone> GetConfirmPhoneList()
        {
            var sesionList = System.Web.HttpContext.Current.Session["ConfirmCellPhoneList"];
            if (sesionList == null)
            {
                System.Web.HttpContext.Current.Session["ConfirmCellPhoneList"] = 
                    new List<defaultWebService.ConfirmPhone>();
            }

            return (List<defaultWebService.ConfirmPhone>)System.Web.HttpContext.Current.Session["ConfirmCellPhoneList"];
        }

        public ActionResult ValidateMobilePhone(string phoneNumber)
        {
            var confirmPhoneList = GetConfirmPhoneList();
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone == phoneNumber);
            if (curentPhone != null)
            {
                confirmPhoneList.Remove(curentPhone);
            }
            curentPhone = new defaultWebService.ConfirmPhone
            {
                Phone = phoneNumber,
                Secret = GetSecret()
            };
            var smsStatus = SendSms(phoneNumber.Replace("+",""), "Kod pidtverdzhenia mob. telefonu: " + curentPhone.Secret);
            if (!string.IsNullOrEmpty(smsStatus.ErrorMessage))
            {
                return Json(new { Status = "Error", Message = smsStatus.ErrorMessage }, JsonRequestBehavior.AllowGet);
            }
            confirmPhoneList.Add(curentPhone);
            return Json(new { Status = "Ok", Message = "Успішно" }, JsonRequestBehavior.AllowGet);
        }
        private SMSInfo SendSms(string phone, string message)
        {
            var smsProvider = new send_sms();
            return smsProvider.Send(phone, message); 
        }
        private string GetSecret()
        {
            var randObj = new Random((int)DateTime.Now.Ticks & 0x0000FFFF);
            return string.Format("{0:F0}", randObj.Next(10000000, 99999999));
        }


        public ActionResult ValidateOneTimePass(string phoneNumber, string code)
        {
           var confirmPhoneList = GetConfirmPhoneList();
            var charsToRemove = new string[] { "+", " " };
            foreach (var c in charsToRemove)
            {
                phoneNumber = phoneNumber.Replace(c, string.Empty);
            }
            var curentPhone = confirmPhoneList.FirstOrDefault(i => i.Phone.Contains(phoneNumber));
            if (curentPhone == null || curentPhone.Secret != code)
            {
                return Json(new { Status = "Error", Message = "Невірний код" }, JsonRequestBehavior.AllowGet);
            }
            confirmPhoneList.Remove(curentPhone);
            return Json(new { Status = "Ok", Message = "Успішно" }, JsonRequestBehavior.AllowGet);
        }

    }
}