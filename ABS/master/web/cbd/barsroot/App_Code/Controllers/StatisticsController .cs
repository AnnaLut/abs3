using System;
using System.Linq;
using System.Web.Mvc;
using barsroot;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class StatisticsController : ApplicationController
    {
        EntitiesBars _entities;

        /// <summary>
        /// початкова сторінка
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int? id)
        {
            return View();
        }

        public ActionResult Users()
        {
            return View();
        }

        public ActionResult UsersList(int page = 1, int limit = 10, int start = 0)
        {
            _entities = new EntitiesBarsCore().NewEntity();
            //var users = new List<WEB_USERMAP>();

            const string where = "a.dbuser = s.logname";

            int total = _entities.ExecuteStoreQuery<int>("select count(*) from staff s, web_usermap a where "+@where).FirstOrDefault();
            //var users = _entities.WEB_USERMAP.OrderBy(i => i.WEBUSER).Skip(start).Take(limit).ToList();
            string sqlText = ServicesClass.GetSelectStryng(
                                               typeSeach: "staff s, web_usermap",
                                               filterString: where,
                                               sort: "a.webuser",
                                               sortDir: "ASC",
                                               rowName: "a.*, s.id as userid",
                                               pageNum: page,
                                               pageSize: limit-1);

            var users = _entities.ExecuteStoreQuery<user>(sqlText).ToList(); 

            /*var users1 = _entities.WEB_USERMAP.Select(i => new
            {
                i.WEBUSER,
                i.DBUSER,
                i.ERRMODE,
                i.WEBPASS,
                i.ADMINPASS,
                i.COMM,
                i.CHGDATE,
                i.BLOCKED
            }).OrderBy(i => i.WEBUSER).Skip(start).Take(limit).ToList();*/

            return Json(new {total, users}, JsonRequestBehavior.AllowGet);
        }

        public JsonResult TopHitsData(decimal? id,string date)
        {
            id = id ?? 20094;
            DateTime pdate = string.IsNullOrWhiteSpace(date) ? DateTime.Now : Convert.ToDateTime(date);
            _entities = new EntitiesBarsCore().NewEntity();
            object[] parameters =
            {
                new OracleParameter("p_userid", OracleDbType.Decimal).Value = id,
                new OracleParameter("p_date", OracleDbType.Date).Value =  pdate,
                new OracleParameter("p_userid", OracleDbType.Decimal).Value = id,
                new OracleParameter("p_date", OracleDbType.Date).Value = pdate
            };
            string sql = @"  SELECT u.func_id, u.staff_id,u.hits, u.last_hit, O.NAME, round(u.hits/c.cnt*100, 2) perc
                                FROM ui_func_hits u, operlist o,
                                (SELECT sum(u.hits) cnt
                                FROM ui_func_hits u, operlist o
                               WHERE     u.staff_id = :p_userid
                                     AND TRUNC (u.last_hit) = TRUNC ( :p_date)
                                     AND u.func_id = O.CODEOPER
                                     AND o.runable = 1) c
                               WHERE     u.staff_id = :p_userid
                                     AND TRUNC (u.last_hit) = TRUNC ( :p_date)
                                     AND u.func_id = O.CODEOPER
                                     AND o.runable = 1
                                     ORDER BY u.hits";
            var data = _entities.ExecuteStoreQuery<TOP_HITS>(sql,parameters).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public class TOP_HITS
        {
            public decimal? FUNC_ID { get; set; }
            public decimal? STAFF_ID { get; set; }
            public decimal? HITS { get; set; }
            public DateTime? LAST_HIT { get; set; }
            public string NAME { get; set; }
            public decimal PERC { get; set; }
        }

        public class user
        {
            public decimal? USERID { get; set; }
            public string WEBUSER { get; set; }
            public string DBUSER { get; set; }
            public decimal? ERRMODE { get; set; }
            public string WEBPASS { get; set; }
            public string ADMINPASS { get; set; }
            public string COMM { get; set; }
            public DateTime? CHGDATE { get; set; }
            public Int16? BLOCKED { get; set; }
        }
    }
}