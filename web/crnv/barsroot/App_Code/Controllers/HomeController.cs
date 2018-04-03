using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Models;
using barsroot.Models;

namespace barsroot.Controllers
{
    //[Authorize]

    public class HomeController : Controller
    {

        EntitiesBars entities;
        /// <summary>
        /// переброс на страницу по умолчанию
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return Redirect(Url.Content("~/barsweb/default.aspx"));
        }

        [AuthorizeSession]       
        public ActionResult Applist()
        {
            var arms= new List<V_OPERAPP>();
            using(entities = new EntitiesBarsCore().GetEntitiesBars())
            {
                arms = (from item in entities.V_OPERAPP where 
                            item.FRONTEND==1 && item.RUNABLE!=3 && item.CODEAPP!="WTOP" 
                        select item).OrderBy(i=>i.APPNAME).ThenBy(i=>i.OPERNAME).ToList();
            }
            return View(arms);
        }
        [AuthorizeSession]  
        public ActionResult Head()
        {
            return View();
        }
    }
}