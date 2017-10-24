using System.Web.Mvc;
using BarsWeb.Controllers;
using System;
using System.IO;
using Newtonsoft.Json.Linq;

namespace BarsWeb.Areas.Crkr.Controllers
{
    [AuthorizeUser]
    public class ClientProfileController : ApplicationController
    {
        public ActionResult Index(string rnk, string button)
        {
            return View();
        }

        public ActionResult CrkrBag(string load)
        {
            return View();
        }
        
        public ActionResult Payments()
        {
            return View();
        }

        public ActionResult ClientBag()
        {
            return View();
        }

        [HttpPost]
        public ActionResult GetFile(string strmodel)
        {
            JObject megamodel = JObject.Parse(strmodel);   
            
            if((string)megamodel["empty"] == "True"){                
                return ReturnFile("compen_person_will.frx", null);
            }         

            string reportName = "compen_person.frx";            
            var pars = new FrxParameters();

            #region Params
            if (megamodel["FullName"] != null)
            {
                string[] fullname = megamodel["FullName"].ToString().Split(' ');
                pars.Add(new FrxParameter("lastname", TypeCode.String, fullname[0]));
                pars.Add(new FrxParameter("firstname", TypeCode.String, fullname[1]));
                pars.Add(new FrxParameter("middlename", TypeCode.String, fullname[2]));
            }           
            pars.Add(new FrxParameter("birthday", TypeCode.String, (string)megamodel["StrBirthday"]));
            pars.Add(new FrxParameter("inn", TypeCode.String, (string)megamodel["INN"]));
            pars.Add(new FrxParameter("sex", TypeCode.String, (string)megamodel["Sex"]));
            pars.Add(new FrxParameter("mobileNumber", TypeCode.String, (string)megamodel["MobileNumber"]));
            pars.Add(new FrxParameter("postIndex", TypeCode.String, (string)megamodel["Postindex"]));
            pars.Add(new FrxParameter("region", TypeCode.String, (string)megamodel["Region"]));
            pars.Add(new FrxParameter("area", TypeCode.String, (string)megamodel["Area"]));
            pars.Add(new FrxParameter("city", TypeCode.String, (string)megamodel["City"]));
            pars.Add(new FrxParameter("addres_street", TypeCode.String, (string)megamodel["Address"]));
            pars.Add(new FrxParameter("addres_home", TypeCode.String, (string)megamodel["Address"]));
            pars.Add(new FrxParameter("addres_room", TypeCode.String, (string)megamodel["Address"]));
            pars.Add(new FrxParameter("docType", TypeCode.String, (string)megamodel["DocumentType"]));

            if((string)megamodel["DocumentType"] == "7")
                pars.Add(new FrxParameter("docser", TypeCode.String, (string)megamodel["EddrId"]));
            else
                pars.Add(new FrxParameter("docser", TypeCode.String, (string)megamodel["Ser"]));
            
            pars.Add(new FrxParameter("docnum", TypeCode.String, (string)megamodel["NumDoc"]));
            pars.Add(new FrxParameter("docdate", TypeCode.String, (string)megamodel["StrIssueDate"]));
            pars.Add(new FrxParameter("docorgan", TypeCode.String, (string)megamodel["Organ"]));
            pars.Add(new FrxParameter("mfo", TypeCode.String, (string)megamodel["Mfo"]));
            pars.Add(new FrxParameter("nls", TypeCode.String, (string)megamodel["Nls"]));
            #endregion

            if ((string)megamodel["flag"] == "funeral")
            {
                ParamsForDepo(pars, megamodel);
                reportName = "compen_person_bud.frx";
            }
            else if ((string)megamodel["flag"] == "burial")
            {
                ParamsForDepo(pars, megamodel);
                reportName = "compen_person.frx";
            }

            return ReturnFile(reportName, pars);
        }

        private void ParamsForDepo(FrxParameters pars, JObject megamodel)
        {
            if (megamodel["fio"] != null)
            {
                string[] fullnameDepo = megamodel["fio"].ToString().Split(' ');
                pars.Add(new FrxParameter("lastname_bud", TypeCode.String, fullnameDepo[0]));
                pars.Add(new FrxParameter("firstname_bud", TypeCode.String, fullnameDepo[1]));
                pars.Add(new FrxParameter("middlename_bud", TypeCode.String, fullnameDepo[2]));
            }           
            pars.Add(new FrxParameter("birthday_bud", TypeCode.String, (string)megamodel["depobdate"]));
            pars.Add(new FrxParameter("docser_bud", TypeCode.String, (string)megamodel["docser"]));
            pars.Add(new FrxParameter("docnum_bud", TypeCode.String, (string)megamodel["docnumb"]));
            pars.Add(new FrxParameter("docdate_bud", TypeCode.String, (string)megamodel["docdate"]));
            pars.Add(new FrxParameter("docorgan_bud", TypeCode.String, (string)megamodel["organ"]));
        }

        private FileContentResult ReturnFile(string templateName, FrxParameters pars)
        {
            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(templateName), pars, null);
            using (var stream = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, stream);
                return File(stream.ToArray(), "application/vnd.ms-pdf", string.Format("Анкета клієнта.pdf"));
            }
        }
    }
}
