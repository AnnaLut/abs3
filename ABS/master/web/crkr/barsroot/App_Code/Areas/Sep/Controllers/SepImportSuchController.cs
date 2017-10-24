using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

 
namespace BarsWeb.Areas.Sep.Controllers
{
    [AuthorizeUser]
    public class SepImportSuchController : ApplicationController
    {

        private readonly ISepParams _repoSepParam;

        public SepImportSuchController(ISepParams repoSepParams)
        {
            _repoSepParam = repoSepParams;
        }

        public ActionResult Index()
        {
            return View();
        }        
       
        public bool ImportSuch(bool recode)
        {
            bool Recode = recode;
            string path = _repoSepParam.GetParam("S_UCHPATH").Value;
            SepImportSuchRepository SepImportSuch = new SepImportSuchRepository();
            SepImportSuch.Import(Recode, path);
            bool success = true;
            return success;
        }   
    }
}