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
    [AuthorizeSession]
    public class WebservicesController : Controller
    {
        EntitiesBars entities;

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Filter(int? id, string table)
        {
            entities = new EntitiesBarsCore().GetEntitiesBars();
            decimal userid = entities.ExecuteStoreQuery<decimal>("select getcurrentuserid from dual").FirstOrDefault();
            META_TABLES meta_tables = new META_TABLES();
            if (id != null)
            {
                meta_tables = entities.META_TABLES.Where(i => i.TABID == id ).FirstOrDefault();
            }
            else
            {
                meta_tables = entities.META_TABLES.Where(i => i.TABNAME == table.ToUpper()).FirstOrDefault();
            }
            ViewBag.UserId = userid;
            return View(meta_tables);
        }

        public ActionResult SetFilter(string name, int tableId, string where, string tables)
        {
            entities = new EntitiesBarsCore().GetEntitiesBars();
            decimal userid = entities.ExecuteStoreQuery<decimal>("select getcurrentuserid from dual").FirstOrDefault();
            
            DYN_FILTER newDynFilter = new DYN_FILTER();
            newDynFilter.TABID = tableId;
            newDynFilter.USERID = userid;
            newDynFilter.SEMANTIC = name;
            newDynFilter.FROM_CLAUSE = tables;
            newDynFilter.WHERE_CLAUSE = where;
            entities.DYN_FILTER.AddObject(newDynFilter);
            entities.SaveChanges();

            return this.Content("ok");
        }
        public ActionResult DelFilter(int id)
        {
            string result="ok";
            entities = new EntitiesBarsCore().GetEntitiesBars();
            decimal userid = entities.ExecuteStoreQuery<decimal>("select getcurrentuserid from dual").FirstOrDefault();
            
            var DynFilter = entities.DYN_FILTER.Where(i=>i.FILTER_ID==id).FirstOrDefault();
            if (DynFilter != null && DynFilter.USERID == userid)
            {
                entities.DeleteObject(DynFilter);
                entities.SaveChanges();
            }
            else
            {
                result = "err";
            }
            return this.Content(result);
        }
    }
}