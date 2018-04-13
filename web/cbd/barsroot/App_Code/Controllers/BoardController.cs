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
    public class BoardController : ApplicationController
    {
        EntitiesBars _entities;

        public ActionResult Index(int pageNum = 1, int pageSize = 20)
        {
            _entities = new EntitiesBarsCore().NewEntity();

            decimal count = _entities.ExecuteStoreQuery<decimal>("select count(*) from bars_board").FirstOrDefault();
            ViewBag.count = count;
            ViewBag.pageNum = pageNum;
            ViewBag.pageSize = pageSize;
            /*var sql = @"select a.* ,
                               s.fio as WRITER_FIO 
                        from bars_board a, 
                             v_board_staff s 
                        where a.writer = s.logname order by a.id desc";*/
            string sqlText = ServicesClass.GetSelectStryng(
                                            typeSeach: "v_board_staff s, bars_board",
                                            filterString: "a.writer = s.logname",
                                            sort: "a.id",
                                            sortDir: "desc",
                                            pageNum: pageNum,
                                            pageSize: pageSize,
                                            rowName: "a.*, s.fio as WRITER_FIO");

            var board = _entities.ExecuteStoreQuery<BARS_BOARD>(sqlText).ToList();
            return View(board);
        }
        public ActionResult Admin(int pageNum = 1, int pageSize = 20)
        {
            _entities = new EntitiesBarsCore().NewEntity();

            decimal count = _entities.ExecuteStoreQuery<decimal>("select count(*) from bars_board").FirstOrDefault();
            ViewBag.count = count;
            ViewBag.pageNum = pageNum;
            ViewBag.pageSize = pageSize;
            /*var sql = @"select a.* ,
                               s.fio as WRITER_FIO 
                        from bars_board a, 
                             v_board_staff s 
                        where a.writer = s.logname order by a.id desc";*/
            string sqlText = ServicesClass.GetSelectStryng(
                                            typeSeach: "v_board_staff s, bars_board",
                                            filterString: "a.writer = s.logname",
                                            sort: "a.id",
                                            sortDir: "desc",
                                            pageNum: pageNum,
                                            pageSize: pageSize,
                                            rowName: "a.*, s.fio as WRITER_FIO");

            var board = _entities.ExecuteStoreQuery<BARS_BOARD>(sqlText).ToList();
            return View(board);
        }
        /// <summary>
        /// вичитка новини
        /// </summary>
        /// <param name="id">ІД новини</param>
        /// <returns></returns>
        public ActionResult News(decimal id)
        {
            string sql = @"select a.* ,
                               s.fio as WRITER_FIO 
                           from bars_board a, 
                             v_board_staff s 
                           where a.writer = s.logname
                                and i.id = :p_id
                           order by a.id desc";
            object[] parameters = { new OracleParameter("p_id", OracleDbType.Decimal).Value = id };
            _entities = new EntitiesBarsCore().NewEntity();
            var news = _entities.ExecuteStoreQuery<BARS_BOARD>(sql,parameters).FirstOrDefault();
            return View(news);
        }

        public ActionResult Add()
        {
            var news = new BARS_BOARD();
            return View("Edit", news);
        }
        [HttpPost]
        [ValidateInput(false)]//для вводу/виводу html коду
        public ActionResult Add(string title, string text)
        {
            string status = "ok";
            string message = "Оголошення збережено";
            string sql = "insert into bars_board (msg_title,msg_text,writer) values(:p_title,:p_text,bars.user_name)";
            object[] parameters =
            {
                new OracleParameter("p_title", OracleDbType.Decimal).Value = title,
                new OracleParameter("p_text", OracleDbType.Decimal).Value = text
            };
            using (_entities = new EntitiesBarsCore().NewEntity())
            {
                try
                {
                    _entities.ExecuteStoreCommand(sql, parameters);
                }
                catch (Exception e)
                {
                    status = "error";
                    message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(new { status, message/*, content = RenderPartialViewToString("News", null)*/ }, JsonRequestBehavior.AllowGet);       
        }
        public ActionResult Edit(decimal id)
        {
            string sql = @"select a.* ,
                               s.fio as WRITER_FIO 
                           from bars_board a, 
                             v_board_staff s 
                           where a.writer = s.logname
                                and a.id = :p_id
                           order by a.id desc";
            object[] parameters = { new OracleParameter("p_id", OracleDbType.Decimal).Value = id };
            _entities = new EntitiesBarsCore().NewEntity();
            var news = _entities.ExecuteStoreQuery<BARS_BOARD>(sql,parameters).FirstOrDefault();
            return View(news);
        }
        [HttpPost]
        [ValidateInput(false)]//для вводу/виводу html коду
        public ActionResult Edit(decimal id, string title, string text)
        {
            string status = "ok";
            string message = "Зміни збережені";
            string sql = "update bars_board set msg_title=:p_title, msg_text=:p_text where id=:p_id";
            object[] parameters =
            {
                new OracleParameter("p_title", OracleDbType.Decimal).Value = title,
                new OracleParameter("p_text", OracleDbType.Decimal).Value = text,
                new OracleParameter("p_id", OracleDbType.Decimal).Value = id
            }; 
            using (_entities = new EntitiesBarsCore().NewEntity())
            {
                try
                {
                    _entities.ExecuteStoreCommand(sql,parameters);
                }
                catch (Exception e)
                {
                    status = "error";
                    message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(new { status, message/*, content = RenderPartialViewToString("News",null)*/ }, JsonRequestBehavior.AllowGet);           
        }
        [HttpPost]
        public ActionResult Delete(decimal[] id)
        {
            string status = "ok";
            string message = "Зміни збережені";
            string sql = "delete from bars_board where id = (:p_id)";

            try
            {
                using (_entities = new EntitiesBarsCore().NewEntity())
                {
                    foreach (var item in id)
                    {
                        object[] parameters =
                        {
                            new OracleParameter("p_id", OracleDbType.Decimal).Value = item
                        };
                        _entities.ExecuteStoreCommand(sql, parameters);
                    }
                }
            }
            catch (Exception e)
            {
                status = "error";
                message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(new { status, message/*, content = RenderPartialViewToString("News",null)*/ }, JsonRequestBehavior.AllowGet);
        }










        public ActionResult Get()
        {
            _entities = new EntitiesBarsCore().NewEntity();
            decimal count = _entities.ExecuteStoreQuery<decimal>("select count(*) from V_USER_MESSAGES").FirstOrDefault();
            ViewBag.count = count;
            const string sql = "select um.*, f_get_userfio(um.MSG_SENDER_ID) as MSG_SENDER_FIO from V_USER_MESSAGES um order by msg_id desc";
            var mess = _entities.ExecuteStoreQuery<V_USER_MESSAGES>(sql).ToList();

            return View(mess);
        }

        public ActionResult CommentAdd(decimal[] id, string comment)
        {
            var status = "ok";
            var message = "Зміни збережено";
            decimal updCount;
            _entities = new EntitiesBarsCore().NewEntity();
            if (id != null)
            {
                object[] parameters =
                    { 
                        new OracleParameter("p_comm",OracleDbType.Varchar2).Value=comment
                    };
                string stringUpdateId = "";
                foreach (var item in id)
                {
                    if (stringUpdateId != "") stringUpdateId += ",";
                    stringUpdateId += Convert.ToString(item);
                }
                try
                {
                    updCount = _entities.ExecuteStoreCommand(
                        "update user_messages set user_comment = :p_comm , msg_done = 1 where msg_id in (" + stringUpdateId + ")",
                        parameters);
                    _entities.SaveChanges();
                    message = Convert.ToString(updCount);
                }
                catch (Exception e)
                {
                     status = "error";
                     message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }

            return Json(new { status, message }, JsonRequestBehavior.AllowGet);
        }
    }
}